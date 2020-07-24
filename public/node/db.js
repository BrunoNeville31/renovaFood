const Sequelize = require('sequelize');
const sequelize = new Sequelize('web_soft_development', 'root', 'Upper@3101',{
    host: 'localhost',
    dialect: 'mysql'
});

sequelize.authenticate().then(() => {
    console.log("logado com Sucesso");
}).catch((err) => {
    console.log("Erro ao conectar" + err );
})
