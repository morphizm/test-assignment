/* eslint-disable valid-jsdoc */
const names = ['Jaclyn',
  'Melony',
  'Regina',
  'Abe',
  'Kaylee',
  'Starla',
  'Dirk',
  'Marylynn',
  'Efrain',
  'Miriam',
  'Verena',
  'Mitchel',
  'Luanne',
  'Fran',
  'Sun',
  'Shanel',
  'Wilfredo',
  'Freddie',
  'Anika',
  'Karma',
  'Leanna',
  'Lizbeth',
  'Ty',
  'Taylor',
  'Shaun',
  'Viva',
  'Peggy',
  'Shannon',
  'Obdulia',
  'Chloe',
  'Kacie',
  'Eldon',
  'Zona',
  'Jordan',
  'Marilee',
  'Kenia',
  'Erline',
  'Merissa',
  'Luther',
  'Clarice',
  'Alexandria',
  'Cicely',
  'Bell',
  'Kieth',
  'Penni',
  'Malorie',
  'Kattie',
  'Sommer',
  'Vicente',
  'DaneSelene',
  'Cedric',
  'Josephina',
  'Thao',
  'Rubi',
  'Dionne',
  'Juliann',
  'Loma',
  'Lessie',
  'Catheryn',
  'Gracie',
  'Allison',
  'Gertha',
  'Marcela',
  'Antonio',
  'Jae',
  'Elba',
  'Eloise',
  'Jay',
  'Christian',
  'Linnie',
  'Carson',
  'Erinn',
  'Lyndsay',
  'Kary',
  'Velva',
  'Anamaria',
  'Kaye',
  'Esteban',
  'Francisca',
  'Charles',
  'Ignacio',
  'Robin',
  'Brigette',
  'Arline',
  'Darin',
  'Lajuana',
  'Francesco',
  'Luann',
  'Kristle',
  'Shalanda',
  'Marva',
  'Audria',
  'Alec',
  'Twana',
  'Quinton',
  'Demetra',
  'Darrick',
  'Jami',
  'Deidra'];

const families = [
  'Maddy',
  'Edens',
  'Oehler',
  'Wilkenson',
  'Willsey',
  'Yarrington',
  'Greear',
  'Droz',
  'Tilton',
  'Cirillo',
  'Luman',
  'Jester',
  'Melgoza',
  'Jaycox',
  'Thibeault',
  'Yawn',
  'Pontes',
  'Leo',
  'Wragg',
  'Johson',
  'Sapp',
  'Aleman',
  'Bewley',
  'Negron',
  'Kensey',
  'Utterback',
  'Copland',
  'Johnsen',
  'Leaf',
  'Litle',
  'Ausherman',
  'Cambareri',
  'Mcree',
  'Moring',
  'Tandy',
  'Juhl',
  'Abrams',
  'Lattin',
  'Lieu',
  'Vowels',
  'Hiles',
  'Rando',
  'Kerner',
  'Grisham',
  'Laprade',
  'Allums',
  'Jaynes',
  'Ladd',
  'Clingman',
  'Earnhardt',
];

const groupIds = {
  1: 'leadership',
  2: 'accounting',
  3: 'human resources',
  4: 'supply department',
};

const getRandomInt = (min, max) => {
  return Math.floor(Math.random() * (max - min)) + min;
};

const generateEmail = (name, family) => {
  const email = `${name}@${family}.ru`;
  return email;
};

const generatePhone = () => {
  let phone = '';
  for (let i = 0; i < 10; i++) {
    const num = getRandomInt(0, 10);
    phone += num.toString();
  }
  return phone;
};

const generateName = () => {
  const len = names.length;
  return names[getRandomInt(0, len)];
};

const generateFamily = () => {
  const len = families.length;
  return families[getRandomInt(0, len)];
};

const makeUser = (groupId, id = 0) => {
  const name = generateName();
  const surname = generateFamily();
  const group = groupIds[groupId];
  const phone = generatePhone();
  const email = generateEmail(name, surname);
  return {name, surname, group, phone, email, id};
};

const dataset = () => {
  const result = [];
  let id = 0;
  for (let i = 0; i < 75; i++) {
    for (let j = 0; j < 4; j++) {
      id++;
      result.push(makeUser(j + 1, id));
    }
  }
  const groups = Object.values(groupIds);
  return JSON.stringify({users: result, groups,
    userKeys: ['name', 'surname', 'group', 'phone', 'email', 'id']});
};
// JSON.parse JSON.stringify
export default dataset;
