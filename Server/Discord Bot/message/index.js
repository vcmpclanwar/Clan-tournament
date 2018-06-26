// import { setInterval } from 'timers';

const Discord = require('discord.js');
const client = new Discord.Client();
var chanel = 0;
const mysql = require('mysql');
var con = mysql.createConnection({
    host: "localhost",
    port: "3306 ",
    user: "discordbot",
    password: "1234",
    database: "mydb"
  });
var id = 1;
var did = 0;
  con.connect(err => {
    if(err) throw err;
    console.log("Connected to Database!");
   var sql = `SELECT count(*) as total FROM serverbot`;
    var query = con.query(sql, function(err, result) {
      if(result != '0')
  {   id = result[0].total;
  }
   console.log(id);
   var sql2 = `SELECT count(*) as total FROM discordmsg`;
    var query2 = con.query(sql2, function(err, rows) {
   did = rows[0].total;
   console.log(did);
   });
   });
});
function checkmsg() {
  var sql = `SELECT count(*) as total FROM discordmsg`;
  var query = con.query(sql, function(err, result) {
    if(did < result[0].total) {
     var abc = `SELECT * FROM discordmsg WHERE id = '${did}'`;
     con.query(abc, function(err, result) {
       if(err) throw err;
       if(result !="") {
      chanel.send(`**${result[0].name}:** ${result[0].text}`);
      did++;
    }});
    };
  });
}

client.on('ready', () => {
  console.log(`Logged in as ${client.user.tag}!`);
  chanel = client.channels.get('441550158573076480');
  chanel.send('Server-Echo Bot Connected!');
  setInterval(checkmsg, 1000);

});


client.on('message', (message) => {
  if(message.author.username === "bot") return;
  if(message.author.username === "Messenger") return;
  if(message.channel.type === "dm") return;
  if(message.channel.id === '441550158573076480')
  {
    id++;
    var sql = `INSERT INTO serverbot (id, name, text) VALUES ('${id}', '${message.author.username}', '${message.content}')`;
    con.query(sql);
    
    console.log(`Message sent. ${id}`);
  }
});


  

    client.login("MzgzODY1MjYxMzE4NzMzODI0.Dc3TAA.nKsNto0BhEbruoK_oFVLCMAzQ_o");
