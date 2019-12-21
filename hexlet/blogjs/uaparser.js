import UAParser from 'ua-parser-js';

export default (req, res, next) => {
  req.useragent = UAParser(req.headers['user-agent']);
  next();
};
