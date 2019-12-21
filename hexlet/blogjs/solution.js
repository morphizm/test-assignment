import Express from 'express';
import session from 'express-session';
import morgan from 'morgan';
import bodyParser from 'body-parser';
import methodOverride from 'method-override';

import Post from './entities/Post';
import NotFoundError from './errors/NotFoundError';
import encrypt from './encrypt';
import User from './entities/User';
import Guest from './entities/Guest';
import flash from './flash';

export default () => {
  const app = new Express();
  app.use(morgan('combined'));
  app.set('view engine', 'pug');
  app.use('/assets', Express.static(process.env.NODE_PATH.split(':')[0]));
  app.use(bodyParser.urlencoded({ extended: false }));
  app.use(methodOverride('_method'));
  app.use(session({
    secret: 'secret key',
    resave: false,
    saveUninitialized: false,
  }));
  app.use(flash());

  let posts = [
    new Post('hello', 'how are you?'),
    new Post('nodejs', 'story about nodejs'),
  ];
  const users = [new User('admin', encrypt('qwerty'))];

  app.use((req, res, next) => {
    if (req.session && req.session.nickname) {
      const { nickname } = req.session;
      res.locals.currentUser = users.find((user) => user.nickname === nickname);
    } else {
      res.locals.currentUser = new Guest();
    }
    next();
  });

  app.get('/', (_req, res) => {
    res.render('index');
  });

  app.get('/posts', (_req, res) => {
    res.render('posts/index', { posts });
  });

  app.get('/posts/new', (_req, res) => {
    res.render('posts/new', { form: {}, errors: {} });
  });

  app.get('/posts/:id', (req, res, next) => {
    const post = posts.find((p) => p.id.toString() === req.params.id);
    if (post) {
      res.render('posts/show', { post });
    } else {
      next(new NotFoundError());
    }
  });


  app.post('/posts', (req, res) => {
    const { title, body } = req.body;

    const errors = {};
    if (!title) {
      errors.title = "Can't be blank";
    }

    if (!body) {
      errors.body = "Can't be blank";
    }

    if (Object.keys(errors).length === 0) {
      const post = new Post(title, body);
      posts.push(post);
      res.redirect(`/posts/${post.id}`);
      return;
    }

    res.status(422);
    res.render('posts/new', { form: req.body, errors });
  });

  app.get('/posts/:id/edit', (req, res) => {
    const post = posts.find((p) => p.id.toString() === req.params.id);
    res.render('posts/edit', { post, form: post, errors: {} });
  });

  app.patch('/posts/:id', (req, res) => {
    const post = posts.find((p) => p.id.toString() === req.params.id);
    const { title, body } = req.body;

    const errors = {};
    if (!title) {
      errors.title = "Can't be blank";
    }

    if (!body) {
      errors.body = "Can't be blank";
    }

    if (Object.keys(errors).length === 0) {
      post.title = title;
      post.body = body;
      res.redirect(`/posts/${post.id}/edit`);
      return;
    }

    res.status(422);
    res.render('posts/edit', { post, form: req.body, errors });
  });

  app.delete('/posts/:id', (req, res) => {
    posts = posts.filter((post) => post.id.toString() !== req.params.id);
    res.redirect('/posts');
  });

  app.get('/users/new', (_req, res) => {
    res.render('users/new', { form: {}, errors: {} });
  });

  app.post('/users', (req, res) => {
    const { nickname, password } = req.body;

    const errors = {};
    if (!nickname) {
      errors.nickname = "Can't be blank";
    } else {
      const isUniq = users.find((user) => user.nickname === nickname) === undefined;
      if (!isUniq) {
        errors.nickname = 'Already exist';
      }
    }

    if (!password) {
      errors.password = "Can't be blank";
    }

    if (Object.keys(errors).length === 0) {
      const user = new User(nickname, encrypt(password));
      users.push(user);
      res.flash('info', `Welcome, ${user.nickname}!`);
      res.redirect('/');
      return;
    }

    res.status(422);
    res.render('users/new', { form: req.body, errors });
  });

  app.get('/session/new', (_req, res) => {
    res.render('session/new', { form: {} });
  });

  app.post('/session', (req, res) => {
    const { nickname, password } = req.body;
    const user = users.find((u) => u.nickname === nickname);
    if (user && user.passwordDigest === encrypt(password)) {
      req.session.nickname = user.nickname;
      res.flash('info', `Welcome, ${user.nickname}!`);
      res.redirect('/');
      return;
    }
    res.status(422);
    res.render('session/new', { form: req.body, error: 'Invalid nickname or password' });
  });

  app.delete('/session', (req, res) => {
    delete req.session.nickname;
    res.flash('info', `Good bye, ${res.locals.currentUser.nickname}`);
    res.redirect('/');
    // req.session.destroy(() => {
    //   res.flash('info', `Good bye, ${res.locals.currentUser.nickname}`);
    //   res.redirect('/');
    // });
  });

  app.use((_req, _res, next) => {
    next(new NotFoundError());
  });

  app.use((err, _req, res, next) => {
    res.status(err.status);
    switch (err.status) {
      case 404:
        res.render(err.status.toString());
        break;
      default:
        next(new Error('Unexpected error'));
    }
  });

  return app;
};
