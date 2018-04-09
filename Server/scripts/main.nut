class PlayerStats
{
 pass = null;
 Level = 0;
 UID = null;
 IP = null;
 AutoLogin = false;
 LoggedIn = false;
 Registered = false;
 banned = false;
 spawnwep = null;
 clan = null;
 kills = 0;
 headshots = 0;
 deaths = 0;
 spree = 0;
 attack = false;
}

const white = "[#FFFFFF]";
const bas = "[#FFDD33]";




function onScriptLoad()
{
 DB <- ConnectSQL("databases/Registration.db");
 status <- array(GetMaxPlayers(), null);
 QuerySQL(DB, "CREATE TABLE if not exists Accounts ( Name TEXT, LowerName TEXT, Password VARCHAR ( 255 ), Level NUMERIC DEFAULT 1, TimeRegistered VARCHAR ( 255 ) DEFAULT CURRENT_TIMESTAMP, UID VARCHAR ( 255 ), IP VARCHAR ( 255 ), AutoLogin BOOLEAN DEFAULT true, Banned TEXT, clan VARCHAR ( 255 ), Kills VARCHAR ( 255 ), Headshots VARCHAR ( 255 ), Deaths VARCHAR ( 255 ), lastjoined VARCHAR ( 255 ) ) ");
 QuerySQL(DB," create table if not exists kicked ( name VARCHAR ( 255 ), admin VARCHAR ( 255 ), date VARCHAR ( 255 ), reason VARCHAR ( 255 ) ) ");
 QuerySQL(DB," create table if not exists warn ( name VARCHAR ( 255 ), admin VARCHAR ( 255 ), date VARCHAR ( 255 ), reason VARCHAR ( 255 ) ) ");
 QuerySQL(DB," create table if not exists slap ( name VARCHAR ( 255 ), admin VARCHAR ( 255 ), date VARCHAR ( 255 ), reason VARCHAR ( 255 ) ) ");
 QuerySQL(DB, "create table if not exists staff (name VARCHAR ( 255 ), rank VARCHAR ( 255 ), madeby VARCHAR ( 255 ) ) "); 
 print("Registeration System Loaded");
 QuerySQL(DB, "CREATE TABLE if not exists Unregistered ( Name TEXT, LowerName TEXT, UID VARCHAR ( 255 ), IP VARCHAR ( 255 ), lastjoined VARCHAR ( 255 ) ) ");

 clan <- ConnectSQL("databases/clans.db");
 QuerySQL(clan, "create table if not exists registered ( name VARCHAR ( 255 ), tag VARCHAR ( 255 ) ) ");
 QuerySQL(clan, "CREATE TABLE if not exists members ( name VARCHAR ( 255 ), tag VARCHAR ( 255 ), player VARCHAR ( 255 ), tgroup INTEGER ) ");
 print("Clan System Loaded");
 
 ban <- ConnectSQL("databases/ban.db");
 QuerySQL(ban, "create table if not exists nameban ( name VARCHAR ( 255 ), admin VARCHAR ( 255), date VARCHAR(255), reason VARCHAR(255)) ");
 QuerySQL(ban, "create table if not exists nameunban ( name VARCHAR ( 255 ), badmin VARCHAR(255), admin VARCHAR (255), date VARCHAR(255), breason VARCHAR(255)) ");
 QuerySQL(ban, "create table if not exists tempban ( name VARCHAR ( 255 ), admin VARCHAR ( 255), date VARCHAR(255), UID VARCHAR ( 255 ), duration VARCHAR(255), expire VARCHAR(255), reason VARCHAR(255)) ");
 QuerySQL(ban, "create table if not exists temunbanned ( name VARCHAR ( 255 ), badmin VARCHAR(255), admin VARCHAR ( 255), duration VARCHAR(255), date VARCHAR(255), breason VARCHAR(255)) ");
 QuerySQL(ban, "create table if not exists permaban ( name VARCHAR ( 255 ), admin VARCHAR ( 255), date VARCHAR(255), UID VARCHAR(255), reason VARCHAR(255)) ");
 QuerySQL(ban, "create table if not exists permaunban ( name VARCHAR ( 255 ), badmin VARCHAR(255), admin VARCHAR ( 255), date VARCHAR(255), breason VARCHAR(255)) ");
AddClass(1, RGB(249, 255, 135), 15, Vector(-657.091, 762.422, 11.5998), -3.13939, 21, 999 ,1, 1, 25, 255 );
AddClass(2, RGB(100, 149, 237), 1, Vector(-823.187, 1150.35, 12.4111), 0.00513555, 21, 999 ,1, 1, 25, 255 );
AddClass(3, RGB(200, 0, 0), 5, Vector(482.096, -92.4237, 10.2305), -3.1172, 21, 999 ,1, 1, 25, 255 );
AddClass(4, RGB(23, 135, 34), 48, Vector(-657.091, 762.422, 11.5998), -3.13939, 21, 999 ,1, 1, 25, 255 );
AddClass(5, RGB(211, 211, 211), 84, Vector(-657.091, 762.422, 11.5998), -3.13939, 21, 999 ,1, 1, 25, 255 );

 
 
 
}

function onScriptUnload()
{
}


function onPlayerJoin( player )
{
	status[player.ID] = PlayerStats();
	checkban(player)
	AccInfo(player);
	MessagePlayer("[#FFDD33]Information:[#FFFFFF] Level: "+status[player.ID].Level+" ("+checklvl(status[player.ID].Level)+")", player);

}

function checkban(player)
{
	local q = QuerySQL(ban, "SELECT * FROM nameban WHERE name = '"+escapeSQLString(player.Name.tolower())+"'");
	local q2 = QuerySQL(ban, "SELECT * FROM permaban WHERE UID = '"+player.UID+"'");
	local q3 = QuerySQL(ban, "SELECT * FROM tempban WHERE UID = '"+player.UID+"'");
	if(q)
	{
		Announce("~y~Banned", 8, player);
		MessagePlayer("[#FFDD33]Information:[#FFFFFF] Banned from Server by Admin: [#D3D3D3]"+GetSQLColumnData(q, 1)+white+" Reason: ["+GetSQLColumnData(q, 0)+"] "+GetSQLColumnData(q, 3)+".", player);
		MessagePlayer("[#FFDD33]Information:[#FFFFFF] If you think that you are wrongfully banned, make an admin report on our forum: ", player);
		KickPlayer(player);
	}
	if(q2)
	{
		Announce("~y~Banned", 8, player);
		MessagePlayer("[#FFDD33]Information:[#FFFFFF] Banned from Server by Admin: [#D3D3D3]"+GetSQLColumnData(q2, 1)+"[#FFFFFF] Reason: ["+GetSQLColumnData(q2, 0)+"] "+GetSQLColumnData(q2, 4)+".", player);
		MessagePlayer("[#FFDD33]Information:[#FFFFFF] If you think that you are wrongfully banned, make an admin report on our forum: ", player);
		KickPlayer(player);
	}
	if(q3)
	{
		if(!checktempban(GetSQLColumnData(q3, 5)))
		{
			Announce("~y~Banned", 8, player);
			MessagePlayer("[#FFDD33]Information:[#FFFFFF] Banned from Server by Admin: [#D3D3D3]"+GetSQLColumnData(q3, 1)+"[#FFFFFF] Reason: ["+GetSQLColumnData(q3, 0)+"] "+GetSQLColumnData(q3, 6)+".", player);
			MessagePlayer("[#FFDD33]Information:[#FFFFFF] If you think that you are wrongfully banned, make an admin report on our forum: ", player);
			MessagePlayer("[#FFDD33]Information:[#FFFFFF] You are banned till: "+GetSQLColumnData(q, 5)+".", player);
			KickPlayer(player);
		
		}
		else
		{
			removetempban(player.UID);
		}
	}
}
function AccInfo(player)
{
 local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '" + escapeSQLString(player.Name.tolower()) + "'");
	if (!q)
	{
		local q2 = QuerySQL(DB, "SELECT * FROM Unregistered WHERE LowerName = '"+escapeSQLString(player.Name.tolower())+"'");
		if(!q2)
		{
			QuerySQL(DB, "INSERT INTO Unregistered (Name, LowerName, UID, IP) VALUES ('"+escapeSQLString(player.Name)+"', '"+escapeSQLString(player.Name.tolower())+"', '"+player.UID+"', '"+player.IP+"') ");
		}
	}
	else
	{
	if(GetSQLColumnData(q, 0) != escapeSQLString(player.Name)) MessagePlayer("[#FF0000]Warning"+white+": Any Capital/small letter of your name doesn't match the database. Please transfer your stats in order to avoid bugs.", player); 
	status[player.ID].pass = GetSQLColumnData(q, 2);
  status[player.ID].Level = GetSQLColumnData(q, 3);
  status[player.ID].UID = GetSQLColumnData(q, 5);
  status[player.ID].IP = GetSQLColumnData(q, 6);
  status[player.ID].AutoLogin = GetSQLColumnData(q, 7);
  status[player.ID].Registered = true;
  status[player.ID].banned = GetSQLColumnData(q, 8);
  status[player.ID].clan = GetSQLColumnData(q, 9);
  status[player.ID].kills = GetSQLColumnData(q, 10).tointeger();
  status[player.ID].headshots = GetSQLColumnData(q, 11).tointeger();
  status[player.ID].deaths = GetSQLColumnData(q, 12).tointeger();
 if ((player.UID == status[player.ID].UID) || (player.IP == status[player.ID].IP))
  {
 if (status[player.ID].AutoLogin == "true")
   {
    MessagePlayer("[#FFDD33] Welcome to the [#FFFF00]VCMP Clan Tournament 2018[#FFFFFF].", player);
	if(status[player.ID].clan != null)
	{
		MessagePlayer("[#FFDD33] Clan : "+status[player.ID].clan+".", player);
	}
    MessagePlayer("[#FFDD33]Information:[#FFFFFF]  You've been auto logged in, to disable this, type /"+bas+"autologin"+white+" [ Toggles automatically ]", player);
    status[player.ID].LoggedIn = true;
   }
   else
   {
    MessagePlayer("[#FFDD33] Welcome to the [#FFFF00]VCMP Clan Tournament 2018[#FFFFFF].", player);
    MessagePlayer("[#FFDD33]Information:[#FFFFFF]  Your nick is registered. Please login in order to access services.", player);
   }
  }
  else
  {
    MessagePlayer("[#FFDD33] Welcome to the [#FFFF00]VCMP Clan Tournament 2018[#FFFFFF].", player);
   MessagePlayer("[#FFDD33]Information:[#FFFFFF]  Your nick is registered. Please login in order to access services.", player);
  }
 }
 else
 {
    MessagePlayer("[#FFDD33] Welcome to the [#FFFF00]VCMP Clan Tournament 2018[#FFFFFF].", player);
  MessagePlayer("[#FFDD33]Information:[#FFFFFF]  Your nick is [#FF0000]not [#FFFFFF]registered. Please use /"+bas+"register[#FFFFFF] in order to access services.", player);
 }
//  FreeSQLQuery(q);
}




function onPlayerPart( player, reason )
{
	local now = date();
	local dat = now.day + "/" + now.month + "/" + now.year + " " + now.hour + ":" + now.min + ":" + now.sec;
	QuerySQL(DB, "UPDATE Accounts SET lastjoined = '"+dat+"' WHERE LowerName = '"+escapeSQLString(player.Name.tolower())+"'");
	QuerySQL(DB, "UPDATE Unregistered SET lastjoined = '"+dat+"' WHERE LowerName = '"+escapeSQLString(player.Name.tolower())+"'");
}

function onPlayerRequestClass( player, classID, team, skin )
{
	if(player.Team == 1) Announce("~y~Team Yellow - Free", player, 8);
	if(player.Team == 2) Announce("~b~Team Blue - Tournament Participant Group 1", player, 8);
	if(player.Team == 3) Announce("~o~Team Red - Tournament Participant Group 2", player, 8);
	if(player.Team == 4) Announce("~t~Team Green - Refree", player, 8);
	if(player.Team == 5) Announce("~h~Team White - Admin", player, 8);
	return 1;
}

function onPlayerRequestSpawn( player )
{
	if(!status[player.ID].Registered)
	{
		MessagePlayer("[#FF0000]Error:[#FFFFFF] You need to be registerd before spawning", player);
		return 0;
	}
	else if(!status[player.ID].LoggedIn)
	{
		MessagePlayer("[#FF0000]Error:[#FFFFFF] You need to be logged in before spawning.", player);
		return 0;
	}
	else
	{
		local lvl = status[player.ID].Level;
		if(lvl < 2 && player.Team != 1) 
		{
			MessagePlayer("[#FF0000]Error:[#FFFFFF] You are neither a tournament participant nor refree so you cannot spawn with the team. Take Team Yellow.", player);
			return 0;
		}
		else if(lvl == 2 &&(player.Team == 3 ||  player.Team == 4 ||  player.Team == 5))
		{
			MessagePlayer("[#FF0000]Error:[#FFFFFF] You are in Tournament Group 1. You can only spawn will Team Yellow or Blue.", player);
			return 0;
		}
		else if(lvl == 3 &&( player.Team == 2 || player.Team == 4 ||  player.Team == 5))
		{
			MessagePlayer("[#FF0000]Error:[#FFFFFF] You are in Tournament Group 2. You can only spawn will Team Yellow or Red.", player);
			return 0;
		}
		else if(lvl == 4 &&(player.Team == 2 || player.Team == 3 || player.Team == 5))
		{
			MessagePlayer("[#FF0000]Error:[#FFFFFF] You are a Refree. You can only spawn will Team Yellow or Green.", player);
			return 0;
		}
		else return 1;
	}
}

function onPlayerSpawn( player )
{
	if(status[player.ID].attack == true) player.CanAttack = true;
	else player.CanAttack = false;
	if(player.Team == 1)
	{
		 player.GiveWeapon(9, 9999);
		 player.GiveWeapon(15, 9999);
		 player.GiveWeapon(18, 9999);
		 player.GiveWeapon(19, 9999);
		 player.GiveWeapon(102, 9999);
		 player.GiveWeapon(32, 9999);
		 player.GiveWeapon(103, 9999);
		 player.GiveWeapon(24, 9999);
	}
	
	
	
	if(player.Team == 2)
	{
		 player.GiveWeapon(4, 9999);
		 player.GiveWeapon(12, 9999);
		 player.GiveWeapon(17, 9999);
		 player.GiveWeapon(21, 9999);
		 player.GiveWeapon(27, 9999);
		 player.GiveWeapon(28, 9999);
		 player.GiveWeapon(31, 9999);
		 player.GiveWeapon(22, 9999);
	}

	

	if(player.Team == 3)
	{
		 player.GiveWeapon(6, 9999);
		 player.GiveWeapon(12, 9999);
		 player.GiveWeapon(18, 9999);
		 player.GiveWeapon(20, 9999);
		 player.GiveWeapon(26, 9999);
		 player.GiveWeapon(32, 9999);
		 player.GiveWeapon(29, 9999);
		 player.GiveWeapon(23, 9999);
	}


	
	if(player.Team == 4)
	{
		 player.GiveWeapon(11, 9999);
		 player.GiveWeapon(13, 9999);
		 player.GiveWeapon(18, 9999);
		 player.GiveWeapon(20, 9999);
		 player.GiveWeapon(26, 9999);
		 player.GiveWeapon(32, 9999);
		 player.GiveWeapon(29, 9999);
		 player.GiveWeapon(25, 9999);
	}
	if(player.Team == 5)
	{
		 player.GiveWeapon(11, 9999);
		 player.GiveWeapon(13, 9999);
		 player.GiveWeapon(18, 9999);
		 player.GiveWeapon(20, 9999);
		 player.GiveWeapon(26, 9999);
		 player.GiveWeapon(32, 9999);
		 player.GiveWeapon(29, 9999);
		 player.GiveWeapon(25, 9999);
	}
}


function onPlayerDeath( player, reason )
{
	if(status[player.ID].spree > 4) Message("[#FFDD33]Information:[#FFFFFF] "+pcol(player.ID)+player.Name+white+" has ended their own killing spree of "+status[player.ID].spree+" kills in a row.");
	status[player.ID].spree = 0;

}

function onPlayerKill( player, killer, reason, bodypart )
{
	status[killer.ID].spree++;
	checkspree(killer.ID);
	if(killer.Health < 80) killer.Health += 20;
	else killer.Health = 100;

	
	if(status[player.ID].spree > 4) Message("[#FFDD33]Information:[#FFFFFF] "+pcol(killer.ID)+killer.Name+ white+" has ended "+pcol(player.ID)+player.Name+white+" killing spree of "+status[player.ID].spree+" kills in a row.");
	status[player.ID].spree = 0;
}

function onPlayerTeamKill( player, killer, reason, bodypart )
{
	if(status[player.ID].spree > 4) Message("[#FFDD33]Information:[#FFFFFF] "+pcol(killer.ID)+killer.Name+ white+" has ended "+pcol(player.ID)+player.Name+white+" killing spree of "+status[player.ID].spree+" kills in a row.");
	status[player.ID].spree = 0;
	killer.Health = 0;
	Message("[#FFDD33]Information:[#FFFFFF] "+pol(killer.ID)+killer.Name+white+" Auto-Killed. Reason: Team Killing.");
	if(status[killer.ID].spree > 4) Message("[#FFDD33]Information:[#FFFFFF] "+pcol(killer.ID)+killer.Name+white+" has ended their own killing spree of "+status[player.ID].spree+" kills in a row.");
	status[killer.ID].spree = 0;
}
function checkspree(p)
{
	local player = FindPlayer(p);
	if(p)
	{
		if(status[player.ID].spree == 5) Message("[#FFDD33]Information:[#FFFFFF] "+pcol(player.ID)+player.Name+white+" is on a killing spree of "+status[player.ID].spree+" kills in a row.");
		if(status[player.ID].spree == 10) Message("[#FFDD33]Information:[#FFFFFF] "+pcol(player.ID)+player.Name+white+" is on a killing spree of "+status[player.ID].spree+" kills in a row.");
		if(status[player.ID].spree == 15) Message("[#FFDD33]Information:[#FFFFFF] "+pcol(player.ID)+player.Name+white+" is on a killing spree of "+status[player.ID].spree+" kills in a row.");
		if(status[player.ID].spree == 20) Message("[#FFDD33]Information:[#FFFFFF] "+pcol(player.ID)+player.Name+white+" is on a killing spree of "+status[player.ID].spree+" kills in a row.");
		if(status[player.ID].spree == 25) Message("[#FFDD33]Information:[#FFFFFF] "+pcol(player.ID)+player.Name+white+" is on a killing spree of "+status[player.ID].spree+" kills in a row.");
		if(status[player.ID].spree == 30) Message("[#FFDD33]Information:[#FFFFFF] "+pcol(player.ID)+player.Name+white+" is on a killing spree of "+status[player.ID].spree+" kills in a row.");
		if(status[player.ID].spree == 35) Message("[#FFDD33]Information:[#FFFFFF] "+pcol(player.ID)+player.Name+white+" is on a killing spree of "+status[player.ID].spree+" kills in a row.");
		if(status[player.ID].spree == 40) Message("[#FFDD33]Information:[#FFFFFF] "+pcol(player.ID)+player.Name+white+" is on a killing spree of "+status[player.ID].spree+" kills in a row.");
		if(status[player.ID].spree == 45) Message("[#FFDD33]Information:[#FFFFFF] "+pcol(player.ID)+player.Name+white+" is on a killing spree of "+status[player.ID].spree+" kills in a row.");
		if(status[player.ID].spree == 50) Message("[#FFDD33]Information:[#FFFFFF] "+pcol(player.ID)+player.Name+white+" is on a killing spree of "+status[player.ID].spree+" kills in a row.");
		if(status[player.ID].spree == 55) Message("[#FFDD33]Information:[#FFFFFF] "+pcol(player.ID)+player.Name+white+" is on a killing spree of "+status[player.ID].spree+" kills in a row.");
		if(status[player.ID].spree == 60) Message("[#FFDD33]Information:[#FFFFFF] "+pcol(player.ID)+player.Name+white+" is on a killing spree of "+status[player.ID].spree+" kills in a row.");
		if(status[player.ID].spree == 65) Message("[#FFDD33]Information:[#FFFFFF] "+pcol(player.ID)+player.Name+white+" is on a killing spree of "+status[player.ID].spree+" kills in a row.");
		if(status[player.ID].spree == 70) Message("[#FFDD33]Information:[#FFFFFF] "+pcol(player.ID)+player.Name+white+" is on a killing spree of "+status[player.ID].spree+" kills in a row.");
		if(status[player.ID].spree == 75) Message("[#FFDD33]Information:[#FFFFFF] "+pcol(player.ID)+player.Name+white+" is on a killing spree of "+status[player.ID].spree+" kills in a row.");
		if(status[player.ID].spree == 80) Message("[#FFDD33]Information:[#FFFFFF] "+pcol(player.ID)+player.Name+white+" is on a killing spree of "+status[player.ID].spree+" kills in a row.");
		if(status[player.ID].spree == 85) Message("[#FFDD33]Information:[#FFFFFF] "+pcol(player.ID)+player.Name+white+" is on a killing spree of "+status[player.ID].spree+" kills in a row.");
		if(status[player.ID].spree == 90) Message("[#FFDD33]Information:[#FFFFFF] "+pcol(player.ID)+player.Name+white+" is on a killing spree of "+status[player.ID].spree+" kills in a row.");
		if(status[player.ID].spree == 95) Message("[#FFDD33]Information:[#FFFFFF] "+pcol(player.ID)+player.Name+white+" is on a killing spree of "+status[player.ID].spree+" kills in a row.");
		if(status[player.ID].spree == 100) Message("[#FFDD33]Information:[#FFFFFF] "+pcol(player.ID)+player.Name+white+" is on a killing spree of "+status[player.ID].spree+" kills in a row.");
	}
}
function onPlayerChat( player, text )
{
local message = text;
	local playerName = pcol(player.ID) + player.Name + white;
	if(message.slice(0,1) == "!" && status[player.ID].clan != null)
	{
		local arguments = GetTok(message, "!", NumTok(message, "!"));
		if(message.len() < 2)
		{
			MessagePlayer("[#FF0000]Error:[#FFFFFF] Use ![text]", player);
			return;
		}
		else
		{
			for(local i = 0; i <= GetMaxPlayers(); i++)
			{
				local plr = FindPlayer(i);
				if(plr && status[plr.ID].clan == status[player.ID].clan)
				{
					MessagePlayer("[#33DD33][CLAN CHAT] [#FFFFFF]"+playerName+": "+arguments, plr);
				}
			}
			return;
		}
	}

	if(message.slice(0,1) == '\\')	
	{
		local text = message.slice(1);
		for ( local i = 0; i < GetMaxPlayers(); i++ )
		{
			local plr = FindPlayer( i );
			if ( plr && plr.Team == player.Team )
			{
				MessagePlayer("[#CC33CC][TEAM CHAT] [#FFFFFF]"+playerName+": "+arguments, plr);
			}
		}
		return;
	}

return 1;
}

function GetTok(string, separator, n, ...)
{
local m = vargv.len() > 0 ? vargv[0] : n,
tokenized = split(string, separator),
text = "";
if (n > tokenized.len() || n < 1) return null;
for (; n <= m; n++)
{
text += text == "" ? tokenized[n-1] : separator + tokenized[n-1];
}
return text;
}

function NumTok(string, separator)
{
local tokenized = split(string, separator);
return tokenized.len();
}


function checklvl(lvl)
{
	if(lvl == 0) return "Unregistered";
	if(lvl == 1) return "Member";
	if(lvl == 2) return "Tournament Participant Group 1";
	if(lvl == 3) return "Tournament Participant Group 2";
	if(lvl == 4) return "Refree";
	if(lvl == 5) return "Admin";
	if(lvl == 6) return "Founder";
}
function pcol(p)
{
	local player = FindPlayer(p);
	if(!player) return;
	else
	{
		if(player.Team == 1) return "[#F9FF87]";
		if(player.Team == 2) return "[#6495ED]";
		if(player.Team == 3) return "[#C80000]";
		if(player.Team == 4) return "[#178722]";
		if(player.Team == 5) return "[#D3D3D3]";
	}
}
function checkmaxdays(month)
{
	switch(month)
	{
		case 1:
			return 31;
			break;
		case 2:
			return 28;
			break;
		case 3:
			return 31;
			break;
		case 4:
			return 30;
			break;
		case 5:
			return 31;
			break;
		case 6:
			return 30;
			break;
		case 7:
			return 31;
			break;
		case 8:
			return 31;
			break;
		case 9:
			return 30;
			break;
		case 10:
			return 31;
			break;
		case 11:
			return 30;
			break;
		case 12:
			return 31;
			break;
	
		default: break;
	}
}
function addbantime(days)
{
	local now = date();
	local month = now.month,
	day = now.day,
	year = now.year,
	nmonth = checkmaxdays(month.tointeger()),
	ndays = day + days.tointeger();

	if(nmonth < ndays)
	{
		month++;
		ndays = ndays - 31;
		if(nmonth < ndays)
		{
			month++;
			ndays = ndays - 31;
		}
		if(nmonth < ndays)
		{
			month++;
			ndays = ndays - 31;
		}
		if(nmonth < ndays)
		{
			month++;
			ndays = ndays - 31;
		}
		if(month > 12)
		{
			year++;
			month = month - 12;
		}
		else
		{
			local dat = ndays + "/" + month + "/" + year + " " + now.hour + ":" + now.min + ":" + now.sec;
			return dat;
		}
	}
	else
	{
		local dat = ndays + "/" + month + "/" + year + " " + now.hour + ":" + now.min + ":" + now.sec;
		return dat;
	}
}


function checktempban(datetime)
{
	local now = date();
	local date = GetTok(datetime, " ", 1);
	local month = now.month,
	day = now.day,
	year = now.year,
	bday = GetTok(date, "/", 1).tointeger(),
	bmonth = GetTok(date, "/", 2).tointeger(),
	byear = GetTok(date, "/", 3).tointeger(),
	fday = bday - day,
	fmonth = bmonth - month,
	fyear = byear - year;

	if(fyear < 0) return 1;
	else if(fyear < 1 && fmonth < 0) return 1;
	else if(fmonth < 1 && fday < 0) return 1;
	else return 0;

	
	
}
function removetempban(uid)
{
	local q = QuerySQL(ban, "SELECT * FROM tempban WHERE UID = '"+uid+"'");
	if(q)
	{
		QuerySQL(ban, "INSERT INTO temunbanned (name, badmin, admin, duration, date, breason) VALUES ('"+GetSQLColumnData(q, 0)+"', '"+GetSQLColumnData(q, 1)+"', 'Server', '"+GetSQLColumnData(q, 4)+"', '"+GetSQLColumnData(q, 2)+"', '"+GetSQLColumnData(q, 6)+"') ");
		QuerySQL(ban, "DELETE FROM tempban WHERE UID = '"+uid+"'");
	}
}
























function onPlayerCommand(player, command, arguments)
{

local cmd, text;
cmd = command.tolower();
text = arguments;
local params;

local playerName = pcol(player.ID) + player.Name + white;


	if(cmd == "register")
	{
		if(status[player.ID].Registered || status[player.ID].LoggedIn || status[player.ID].Level > 0) MessagePlayer("[#FF0000]Error:[#FFFFFF] Nick already Registered.", player);
		else if(!arguments) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <password>", player);
		else if(arguments.len() < 4) MessagePlayer("[#FF0000]Error:[#FFFFFF] Password should contain atleast 4 characters.", player);
		else
		{
			status[player.ID].Level = 1;
			status[player.ID].Registered = true;
			status[player.ID].LoggedIn = true;
			local now = date();
			QuerySQL(DB, "INSERT INTO Accounts ( Name, LowerName, Password, Level, TimeRegistered, UID, IP, AutoLogin, Banned, Kills, Headshots, Deaths ) VALUES ('"+escapeSQLString(player.Name)+"', '"+escapeSQLString(player.Name.tolower())+"', '"+SHA256(arguments)+"', '1', '" + now.day + "/" + now.month + "/" + now.year + " " + now.hour + ":" + now.min + ":" + now.sec + "', '"+player.UID+"', '"+player.IP+"', 'true', 'No', '0', '0', '0') ");
			MessagePlayer("[#FFDD33]Information:[#FFFFFF] You are now registered on the Server.", player);
			MessagePlayer("[#FFDD33]Information:[#FFFFFF] AutoLogin is set to Yes by default. To turn it off use /"+bas+"autologin"+white+" (toggles Automatically) to turn it off", player);
		}
	}

	else if(cmd == "login")
	{
		if(!status[player.ID].Registered) MessagePlayer("[#FF0000]Error:[#FFFFFF] You are not registered.", player);
		else if(status[player.ID].LoggedIn) MessagePlayer("[#FF0000]Error:[#FFFFFF] Already Logged in.", player);
		else if(!arguments) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <password>", player);
		else
		{
			local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(player.Name.tolower())+"'");
			if(!q) MessagePlayer("[#FF0000]Error:[#FFFFFF] There is a problem with your account. Please Contact a developer of the server.", player)
			else
			{
				if(SHA256(arguments) != status[player.ID].pass) MessagePlayer("[#FF0000]Error:[#FFFFFF] Wrong Password.", player);
				else
				{
					status[player.ID].LoggedIn = true;
					MessagePlayer("[#FFDD33]Information:[#FFFFFF] You are Logged in.", player);
				}
			}
		}
	}
	else if(cmd == "credits")
	{
		MessagePlayer("[#FFDD33]Information:[#FFFFFF] This Server is created by umar4911 and Tdz.Kurumi.", player);
	}

	else if(!status[player.ID].Registered)
	{
		MessagePlayer("[#FF0000]Error:[#FFFFFF] You need to register first. Use /"+bas+"register", player);
	}
	else if(!status[player.ID].LoggedIn)
	{
		MessagePlayer("[#FF0000]Error:[#FFFFFF] You need to login first. Use /"+bas+"login", player);
	}
	
	else
	{

	if(cmd == "autologin")
	{
		local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(player.Name.tolower())+"'");
		if(q)
		{
			if(GetSQLColumnData(q, 7) == "true")
			{
				QuerySQL(DB, "UPDATE Accounts SET AutoLogin = 'false' WHERE LowerName = '"+escapeSQLString(player.Name.tolower())+"'");
				MessagePlayer("[#FFDD33]Information:[#FFFFFF] You have Disabled AutoLogin.", player);
			}
			else
			{
				QuerySQL(DB, "UPDATE Accounts SET AutoLogin = 'true' WHERE LowerName = '"+escapeSQLString(player.Name.tolower())+"'");
				MessagePlayer("[#FFDD33]Information:[#FFFFFF] You have Enabled AutoLogin.", player);
			}
		}
	}
	
	else if(cmd == "changepass" || cmd == "changepassword")
	{
		if(!arguments || NumTok(arguments, " ") < 2 || GetTok(arguments, " ", 1) == null || GetTok(arguments, " ", 2) == null ) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <old password> <new password>", player);
		else if(GetTok(arguments, " ", 2).len() < 4) MessagePlayer("[#FF0000]Error:[#FFFFFF] New Password should contain atlest 4 characters.", player);
		else if(SHA256(GetTok(arguments, " ", 1)) != status[player.ID].pass) MessagePlayer("[#FF0000]Error:[#FFFFFF] Wrong Old Password entered.", player);
		else
		{
			status[player.ID].pass = SHA256(GetTok(arguments, " ", 2));
			QuerySQL(DB, "UPDATE Accounts SET Password = '"+status[player.ID].pass+"' WHERE LowerName = '"+escapeSQLString(player.Name.tolower())+"'");
			MessagePlayer("[#FFDD33]Information:[#FFFFFF] Your password has been updated.", player);
		}
	}

	
	else if( cmd == "wep" || cmd == "we" )
	{
		if( !text ) return MessagePlayer( "[#FF0000]Error:[#FFFFFF] /"+cmd+" <wep 1> <wep 2> <...>", player );
		else
		{
			local params = split( text, " " ); 
			player.SetWeapon(0,0);
			local weapons; // Create a new null variable which will be holding the list of weapons player took.
			local b;
			b = 0;
			for( local i = 0; i <= params.len() - 1; i++ ) // since the 'len' returns value from 1 and array's starting value point is 0, we will use len() - 1 otherwise we'll receive an error.
			{
				if( !IsNum( params[i] ) && GetWeaponID( params[i]) && GetWeaponID( params[i]) > 0 && GetWeaponID( params[i]) <= 32 ) // if Name was specified. 
				{
					player.SetWeapon( GetWeaponID( params[i] ), 99999 ); // Get the weapon ID from its Name
					if(b == 0)
					{
						weapons = GetWeaponName(GetWeaponID(params[i])); // Add the weapon name to given weapon list
						b=b+1;
					}
					else
					{
						weapons = weapons + ", " + GetWeaponName(GetWeaponID(params[i]));
					}

				}
	
				else if( IsNum( params[i] ) && params[i].tointeger() < 33 && params[i].tointeger() > 0  ) // if ID was specified
				{
					player.SetWeapon( params[i].tointeger(), 99999 ); // Then just give player that weapon
					weapons = GetWeaponName( params[i].tointeger() ); // Get the weapon name from the ID and add it.
					if(b == 0)
					{
						weapons = GetWeaponName( params[i].tointeger() ); // Add the weapon name to given weapon list
						b=b+1;
					}
					else
					{
						weapons = weapons + ", " + GetWeaponName( params[i].tointeger() );
					}

					
					//MessagePlayer("[#FFDD33]Information:[#FFFFFF] You received the following weapon: "+weapons+".", player);
					//status[player.ID].wepcmd = true;
					//NewTimer("wepcmdf", 1000, 1, player.ID);

				}
				else MessagePlayer( "[#FFDD33]Information:[#FFFFFF] Invalid Weapon Name/ID", player ); // if the invalid ID/Name was given
			}
			if(weapons != null) MessagePlayer("[#FFDD33]Information:[#FFFFFF] You received the following weps : "+weapons+".", player);
		}
	}

	
	
	
	
	else if(cmd == "spawnwep")
	{
		if(!arguments) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+cmd+" [wep1] [wep2] [wep3] ...", player);
		else
		{
			for (local i = 0 ; i <200 ; i++)
			{
				player.RemoveWeapon(i);
			}
			status[player.ID].spawnwep = arguments;
			local params = split( text, " " ); 
			player.SetWeapon(0,0);
			local weapons; // Create a new null variable which will be holding the list of weapons player took.
			local b;
			b = 0;
			for( local i = 0; i <= params.len() - 1; i++ ) // since the 'len' returns value from 1 and array's starting value point is 0, we will use len() - 1 otherwise we'll receive an error.
			{
				if( !IsNum( params[i] ) && GetWeaponID( params[i]) && GetWeaponID( params[i]) > 0 && GetWeaponID( params[i]) <= 32 ) // if Name was specified. 
				{
					player.SetWeapon( GetWeaponID( params[i] ), 99999 ); // Get the weapon ID from its Name
					if(b == 0)
					{
						weapons = GetWeaponName(GetWeaponID(params[i])); // Add the weapon name to given weapon list
						b=b+1;
					}
					else
					{
						weapons = weapons + ", " + GetWeaponName(GetWeaponID(params[i]));
					}

				}
	
				else if( IsNum( params[i] ) && params[i].tointeger() < 33 && params[i].tointeger() > 0  ) // if ID was specified
				{
					player.SetWeapon( params[i].tointeger(), 99999 ); // Then just give player that weapon
					weapons = GetWeaponName( params[i].tointeger() ); // Get the weapon name from the ID and add it.
					if(b == 0)
					{
						weapons = GetWeaponName( params[i].tointeger() ); // Add the weapon name to given weapon list
						b=b+1;
					}
					else
					{
						weapons = weapons + ", " + GetWeaponName( params[i].tointeger() );
					}
				}
				else MessagePlayer( "[#FFDD33]Information:[#FFFFFF] Invalid Weapon Name/ID", player ); // if the invalid ID/Name was given
			}
			if(weapons != null) MessagePlayer("[#FFDD33]Information:[#FFFFFF] You received the following weps : "+weapons+".", player);
		}
	}

	else if(cmd == "sethealth" || cmd == "sethp")
	{
		if(status[player.ID].Level < 5) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments || NumTok(arguments, " ") < 2) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <player> <0-100>", player);
		else if(!IsNum(GetTok(arguments, " ", 2)) || GetTok(arguments, " ", 2).tointeger() < 0 || GetTok(arguments, " ", 2).tointeger() > 100) MessagePlayer("[#FF0000]Error:[#FFFFFF] Health must be in numbers and between 0-100", player);
		else
		{
			local plr = FindPlayer(GetTok(arguments, " ", 1));
			if(!plr) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
			else
			{
				plr.Health = GetTok(arguments, " ", 2).tointeger();
				Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" set hp of player: "+pcol(plr.ID)+ plr.Name + white+" to: "+GetTok(arguments, " ", 2)+".");
			}
		}
	}

	else if(cmd == "canattack")
	{
		if(status[player.ID].Level < 5) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <player>", player);
		else
		{
			local plr = FindPlayer(arguments);
			if(!plr) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
			else
			{
				if(plr.CanAttack == true) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Player: "+pcol(plr.ID) + plr.Name + white+" can attack.", player);
				else MessagePlayer("[#FFDD33]Information:[#FFFFFF] Player: "+pcol(plr.ID) + plr.Name + white+" Cannot Attack.", player);
			}
		}
	}
	else if(cmd == "setattack")
	{
		if(status[player.ID].Level < 5) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments || NumTok(arguments, " ") < 2) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <player> <yes/no>", player);
		else
		{
			local plr = FindPlayer(GetTok(arguments, " ", 1));
			if(!plr) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
			else
			{
				if(GetTok(arguments, " ", 2) == "yes")
				{
					plr.CanAttack = true;
					Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" set attack of player: "+pcol(plr.ID) + plr.Name + white+" to [#33CC33] True"+white+".");
					MessagePlayer("[#FFDD33]Information:[#FFFFFF] Now you can attack/DM.", plr);
				}
				else if(GetTok(arguments, " ", 2) == "no")
				{
					plr.CanAttack = false;
					Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" set attack of player: "+pcol(plr.ID) + plr.Name + white+" to [#33CC33] False"+white+".");
					MessagePlayer("[#FFDD33]Information:[#FFFFFF] Now you cannot attack/DM.", plr);
				}
				else MessagePlayer("[#FF0000]Error:[#FFFFFF] The Bool must be Yes or no.", player);
			}
		}
	}
	else if(cmd == "setspawnattack")
	{
		if(status[player.ID].Level < 5) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments || NumTok(arguments, " ") < 2) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <player> <yes/no>", player);
		else
		{
			local plr = FindPlayer(GetTok(arguments, " ", 1));
			if(!plr) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
			else
			{
				if(GetTok(arguments, " ", 2) == "yes")
				{
					plr.CanAttack = true;
					status[plr.ID].attack = true;
					Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" set attack of player: "+pcol(plr.ID) + plr.Name + white+" to [#33CC33] True"+white+".");
					MessagePlayer("[#FFDD33]Information:[#FFFFFF] Now you can attack/DM.", plr);
				}
				else if(GetTok(arguments, " ", 2) == "no")
				{
					plr.CanAttack = false;
					status[plr.ID].attack = false;
					Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" set attack of player: "+pcol(plr.ID) + plr.Name + white+" to [#33CC33] False"+white+".");
					MessagePlayer("[#FFDD33]Information:[#FFFFFF] Now you cannot attack/DM.", plr);
				}
				else MessagePlayer("[#FF0000]Error:[#FFFFFF] The Bool must be Yes or no.", player);
			}
		}
	}
	
   else if ( cmd == "kick" )
    {
		
        if (status[player.ID].Level < 5 ) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments || NumTok(arguments, " ") < 2) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <player> <reason>", player);
		else
		{
			local plr = FindPlayer(GetTok(arguments, " ", 1));
			local reas = GetTok(arguments, " ", NumTok(arguments, " "));
			if(!plr) MessagePlayer("[#FF0000]Error:[#FFFFFF] Invalid Player", player);
			else if(status[player.ID].Level <= status[plr.ID].Level) MessagePlayer("[#FF0000]Error:[#FFFFFF] You cannot kick admin equal or higher than you", player);
			else
			{
				Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" kicked player : " + pcol(plr.ID) + plr.Name + white + " Reason : "+reas+".");
				local now = date();
				local dat = now.day + "/" + now.month + "/" + now.year + " " + now.hour + ":" + now.min + ":" + now.sec;
				QuerySQL(DB, "INSERT INTO kick (name, admin, date, reason) VALUES ('"+escapeSQLString(player.Name.tolower())+"', '"+escapeSQLString(plr.Name.tolower())+"', '"+dat+"', '"+reas+"') ");
				KickPlayer( plr );
			}
		}
	}
	
	else if(cmd == "warn")
	{
		if(status[player.ID].Level < 5) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments || NumTok(arguments, " ") < 2) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use / " bas + cmd + " <plr> <reason> ", player);
		else
		{
			local plr = FindPlayer(GetTok(arguments, " ", 1));
			local reas = GetTok(arguments, " ", 2, NumTok(arguments, " "));
			if(!plr) MessagePlayer("[#FF0000]Error:[#FFFFFF] Invalid Player", player);
			else if(status[player.ID].Level <= status[plr.ID].Level) MessagePlayer("[#FF0000]Error:[#FFFFFF] You cannot warn any admin equal or higher than you", player);
			else 
			{
				Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" warned player : " + pcol(plr.ID) + plr.Name + white + " Reason : " + reas + ".");
				MessagePlayer("[#FFDD33]Information:[#FFFFFF] You have been warned by Admin:"+playerName+" Reason: "+reas+".", plr);
				local now = date();
				local dat = now.day + "/" + now.month + "/" + now.year + " " + now.hour + ":" + now.min + ":" + now.sec;
				Announce("~r~ Warned ", plr, 8);
				QuerySQL(DB, "INSERT INTO warn (name, admin, date, reason) VALUES ('"+escapeSQLString(player.Name.tolower())+"', '"+escapeSQLString(plr.Name.tolower())+"', '"+dat+"', '"+reas+"') ");
			}
		}
	}
	else if(cmd == "slap")
	{
		if(status[player.ID].Level < 3) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments || NumTok(arguments, " ") < 2) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas + cmd + " [plr] [Reason]", player);
		else
		{
			local plr = FindPlayer(GetTok(arguments, " ", 1));
			if(!plr) MessagePlayer("[#FF0000]Error:[#FFFFFF] Invalid Player", player);
			else if(status[player.ID].Level <= status[plr.ID].Level) MessagePlayer("[#FF0000]Error:[#FFFFFF] You cannot slap any admin equal or higher than you", player);
			else
			{
				plr.Pos = Vector(plr.Pos.x, plr.Pos.y, plr.Pos.z + 5);	
				local reas = GetTok(arguments, " ", 2, NumTok(arguments, " "));
				Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" slapped player : " + pcol(plr.ID) + plr.Name + white + " Reason : " + reas + ".");
				local now = date();
				local dat = now.day + "/" + now.month + "/" + now.year + " " + now.hour + ":" + now.min + ":" + now.sec;
				MessagePlayer("[#FFDD33]Information:[#FFFFFF] You have been slapped by Admin:"+playerName+" Reason: "+reas+".", plr);
				QuerySQL(DB, "INSERT INTO slap (name, admin, date, reason) VALUES ('"+escapeSQLString(player.Name.tolower())+"', '"+escapeSQLString(plr.Name.tolower())+"', '"+dat+"', '"+reas+"') ");
			}
		}
	}
	
	else if ( cmd == "addrefree" || cmd == "setrefree")
	{
		if(status[player.ID].Level < 6) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access.", player);
		else if(!arguments) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <player>", player);
		else
		{
			local plr = FindPlayer(arguments);
			if(plr)
			{
				local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(plr.Name.tolower())+"'");
				if(!q) MessagePlayer("[#FF0000]Error:[#FFFFFF] Player is not registered.", player);
				else
				{
					status[player.ID].Level = 4;
					QuerySQL(DB, "UPDATE Accounts SET Level = '4' WHERE LowerName = '"+escapeSQLString(plr.Name.tolower())+"'");
					QuerySQL(DB, "INSERT INTO staff ( name, rank, madeby ) VALUES ('"+escapeSQLString(plr.Name.tolower())+"', 'refree', '"+escapeSQLString(player.Name.tolower())+"') ");
					Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" changed rank of player: "+pcol(plr.ID)+plr.Name+white+" to: "+checklvl(status[player.ID].Level)+".");
					MessagePlayer("[#FFDD33]Information:[#FFFFFF] Now you are a refree. Type /"+bas+"refreehelp"+white+" to learn about it.", player);
				}
			}
			else
			{
				local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(arguments.tolower())+"'");
				if(!q) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
				else
				{
					QuerySQL(DB, "INSERT INTO staff ( name, rank, madeby ) VALUES ('"+arguments.tolower()+"', 'refree', '"+escapeSQLString(player.Name.tolower())+"') ");
					QuerySQL(DB, "UPDATE Accounts SET Level = '4' WHERE LowerName = '"+escapeSQLString(arguments.tolower())+"'");
					Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" set: [#D3D3D3]"+GetSQLColumnData(q, 0)+white+" rank to: "+checklvl(status[player.ID].Level)+".");
				}
			}
		}
	}
	
	else if ( cmd == "addadmin" || cmd == "setadmin")
	{
		if(status[player.ID].Level < 6) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access.", player);
		else if(!arguments) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <player>", player);
		else
		{
			local plr = FindPlayer(arguments);
			if(plr)
			{
				local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(plr.Name.tolower())+"'");
				if(!q) MessagePlayer("[#FF0000]Error:[#FFFFFF] Player is not registered.", player);
				else
				{
					status[plr.ID].Level = 5;
					QuerySQL(DB, "UPDATE Accounts SET Level = '5' WHERE LowerName = '"+escapeSQLString(plr.Name.tolower())+"'");
					QuerySQL(DB, "INSERT INTO staff ( name, rank, madeby ) VALUES ('"+escapeSQLString(plr.Name.tolower())+"', 'admin', '"+escapeSQLString(player.Name.tolower())+"') ");
					Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" changed rank of player: "+pcol(plr.ID)+plr.Name+white+" to: Admin.");
					MessagePlayer("[#FFDD33]Information:[#FFFFFF] Now you are a Admin. Type /"+bas+"refreehelp"+white+" to learn about it.", player);
				}
			}
			else
			{
				local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(arguments.tolower())+"'");
				if(!q) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
				else
				{
					QuerySQL(DB, "INSERT INTO staff ( name, rank, madeby ) VALUES ('"+arguments.tolower()+"', 'admin', '"+escapeSQLString(player.Name.tolower())+"') ");
					QuerySQL(DB, "UPDATE Accounts SET Level = '5' WHERE LowerName = '"+escapeSQLString(arguments.tolower())+"'");
					Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" set: [#D3D3D3]"+GetSQLColumnData(q, 0)+white+" rank to: Admin.");
				}
			}
		}
	}

	
	else if(cmd == "addclan")
	{
		if(status[player.ID].Level < 6) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access.", player);
		else if(!arguments || NumTok(arguments, " ") < 2) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <clan tag> <clan name>", player);
		else
		{
			local q = QuerySQL(clan, "SELECT * FROM registered WHERE tag = '"+GetTok(arguments, " ", 1)+"'");
			local q2 = QuerySQL(clan, "SELECT * FROM registered WHERE name = '"+GetTok(arguments, " ", 2, NumTok(arguments, " "))+"'");
			if(q) MessagePlayer("[#FF0000]Error:[#FFFFFF] Clan with that tag already exists.", player);
			else if(q2) MessagePlayer("[#FF0000]Error:[#FFFFFF] Clan with that name already exists.", player);
			else
			{
				QuerySQL(clan, "INSERT INTO registered (name, tag) VALUES ('"+GetTok(arguments, " ", 2, NumTok(arguments, " "))+"', '"+GetTok(arguments, " ", 1)+"') ");
				Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" added: "+GetTok(arguments, " ", 2, NumTok(arguments, " "))+" in the clan tournament.");
			}
		}
	}
	
	else if(cmd == "removeclan" || cmd == "delclan" || cmd == "deleteclan")
	{
		if(status[player.ID].Level < 6) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access.", player);
		else if(!arguments) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <clan tag>", player);
		else
		{
			local q = QuerySQL(clan, "SELECT * FROM registered WHERE tag = '"+GetTok(arguments, " ", 1)+"'");
			if(!q) MessagePlayer("[#FF0000]Error:[#FFFFFF] Clan does not exists.", player);
			else
			{
				QuerySQL(DB, "UPDATE Accounts SET clan = null WHERE clan = '"+GetSQLColumnData(q, 0)+"'");
				QuerySQL(clan, "DELETE FROM registered WHERE tag = '"+arguments+"'");
				QuerySQL(clan, "DELETE FROM members WHERE tag = '"+arguments+"'");
				Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" removed clan: "+GetSQLColumnData(q, 0)+" from the clan tournament.");
			}
		}
	}


	else if(cmd == "addclanmember")
	{
		if(status[player.ID].Level < 6) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments || NumTok(arguments, " ") < 2) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <clan tag> <player name>", player);
		else
		{
			local q = QuerySQL(clan, "SELECT * FROM registered WHERE tag = '"+GetTok(arguments, " ", 1)+"'");
			if(!q) MessagePlayer("[#FF0000]Error:[#FFFFFF] Clan does not exists.", player);
			else
			{
				local plr = FindPlayer(GetTok(arguments, " ", 2));
				if(plr)
				{
					local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(plr.Name.tolower())+"'");
					if(!q) MessagePlayer("[#FF0000]Error:[#FFFFFF] Player is not registered.", player);
					else
					{
						local q2 = QuerySQL(clan, "SELECT * FROM members WHERE player = '"+escapeSQLString(plr.Name.tolower())+"'");
						if(q2) MessagePlayer("[#FF0000]Error:[#FFFFFF] The player already is in clan: "+GetSQLColumnData(q, 1)+".", player);
						else
						{
							status[player.ID].clan = GetSQLColumnData(q, 0);
							QuerySQL(clan, "INSERT INTO members ( name, tag, player) VALUES ('"+GetSQLColumnData(q, 0)+"', '"+GetSQLColumnData(q, 1)+"', '"+escapeSQLString(plr.Name.tolower())+"') ");
							QuerySQL(DB, "UPDATE Accounts SET clan = '"+GetSQLColumnData(q, 0)+"' WHERE LowerName = '"+escapeSQLString(plr.Name.tolower())+"'");
							MessagePlayer("[#FFDD33]Information:[#FFFFFF] You have been added in clan: "+GetSQLColumnData(q, 0)+".", player);
							Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" added player: "+pcol(plr.ID)+plr.Name+white+" in clan: "+GetSQLColumnData(q, 0)+".");
						}
					}
				}
				else
				{
					local q3 = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(GetTok(arguments, " ", 2).tolower())+"'");
					if(!q3) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
					else
					{
						local q4 = QuerySQL(clan, "SELECT * FROM members WHERE player = '"+escapeSQLString(GetTok(arguments, " ", 2).tolower())+"'");
						if(q4) MessagePlayer("[#FF0000]Error:[#FFFFFF] The player already is in clan: "+GetSQLColumnData(q, 1)+".", player);
						else
						{
							QuerySQL(clan, "INSERT INTO members ( name, tag, player) VALUES ('"+GetSQLColumnData(q, 0)+"', '"+GetSQLColumnData(q, 1)+"', '"+escapeSQLString(GetTok(arguments, " ", 2).tolower())+"') ");
							QuerySQL(DB, "UPDATE Accounts SET clan = '"+GetSQLColumnData(q, 0)+"' WHERE LowerName = '"+escapeSQLString(GetTok(arguments, " ", 2).tolower())+"'");
							Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" added player:[#D3D3D3] "+GetSQLColumnData(q3, 0)+white+" in clan: "+GetSQLColumnData(q, 0)+".");
						}
					}
				}
			}
		}
	}
	
	else if(cmd == "delclanmember" || cmd == "removeclanmember")
	{
		if(status[player.ID].Level < 6) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments || NumTok(arguments, " ") < 2) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <clan tag> <player name>", player);
		else
		{
			local q = QuerySQL(clan, "SELECT * FROM registered WHERE tag = '"+GetTok(arguments, " ", 1)+"'");
			if(!q) MessagePlayer("[#FF0000]Error:[#FFFFFF] Clan does not exists.", player);
			else
			{
				local plr = FindPlayer(GetTok(arguments, " ", 2));
				if(plr)
				{
					local q2 = QuerySQL(clan, "SELECT * FROM members WHERE player = '"+escapeSQLString(plr.Name.tolower())+"'");
					if(!q2) MessagePlayer("[#FF0000]Error:[#FFFFFF] The player is not clan: "+GetSQLColumnData(q, 1)+".", player);
					else
					{
						local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(plr.Name.tolower())+"'");
						if(!q) MessagePlayer("[#FF0000]Error:[#FFFFFF] Player is not registered.", player);
						else
						{
							status[player.ID].Level = 1;
							status[player.ID].clan = null;
							QuerySQL(DB, "UPDATE Accounts SET Level = '1' WHERE LowerName = '"+escapeSQLString(plr.Name.tolower())+"'");
							QuerySQL(clan, "DELETE FROM members WHERE player = '"+escapeSQLString(plr.Name.tolower())+"'");
							QuerySQL(DB, "UPDATE Accounts SET clan = null WHERE LowerName = '"+escapeSQLString(plr.Name.tolower())+"'");
							MessagePlayer("[#FFDD33]Information:[#FFFFFF] You have been removed deom clan: "+GetSQLColumnData(q, 0)+".", player);
							Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" removed player: "+pcol(plr.ID)+plr.Name+white+" from clan: "+GetSQLColumnData(q, 0)+".");
						}
					}
				}
				else
				{
					local q3 = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(GetTok(arguments, " ", 2).tolower())+"'");
					if(!q3) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
					else
					{
						local q4 = QuerySQL(clan, "SELECT * FROM members WHERE player = '"+escapeSQLString(GetTok(arguments, " ", 2).tolower())+"'");
						if(!q4) MessagePlayer("[#FF0000]Error:[#FFFFFF] The player is not in clan: "+GetSQLColumnData(q, 1)+".", player);
						else
						{
							QuerySQL(DB, "UPDATE Accounts SET Level = '1' WHERE LowerName = '"+escapeSQLString(arguments.tolower())+"'");
							QuerySQL(clan, "DELETE FROM members WHERE player = '"+escapeSQLString(arguments.tolower())+"'");
							QuerySQL(DB, "UPDATE Accounts SET clan = null WHERE LowerName = '"+escapeSQLString(arguments.tolower())+"'");
							Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" removed player:[#D3D3D3] "+GetSQLColumnData(q3, 0)+white+" from clan: "+GetSQLColumnData(q, 0)+".");
						}
					}
				}
			}
		}
	}

	else if(cmd == "clan")
	{
		if(!arguments)
		{
			if(status[player.ID].clan == null) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Player: "+playerName+" Clan: Null", player);
			else MessagePlayer("[#FFDD33]Information:[#FFFFFF] Player: "+playerName+" Clan: "+status[player.ID].clan, player);
		}
		else
		{
			local plr = FindPlayer(arguments);
			if(!plr)
			{
				if(status[player.ID].clan == null) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Player: "+playerName+" Clan: Null", player);
				else MessagePlayer("[#FFDD33]Information:[#FFFFFF] Player: "+playerName+" Clan: "+status[player.ID].clan, player);
			}
			else
			{
				if(status[plr.ID].clan == null) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Player: "+pcol(plr.ID)+plr.Name+white+" Clan: Null", player);
				else MessagePlayer("[#FFDD33]Information:[#FFFFFF] Player: "+pcol(plr.ID)+plr.Name+white+" Clan: "+status[plr.ID].clan, player);
			}
		}
	}
	
	else if(cmd == "level")
	{
		if(!arguments)
		{
			MessagePlayer("[#FFDD33]Information:[#FFFFFF] Player: "+playerName+" Level: "+status[player.ID].Level+" ("+checklvl(status[player.ID].Level)+").", player);
		}
		else
		{
			local plr = FindPlayer(arguments);
			if(!plr)
			{
				MessagePlayer("[#FFDD33]Information:[#FFFFFF] Player: "+playerName+" Level: "+status[player.ID].Level+" ("+checklvl(status[player.ID].Level)+").", player);
			}
			else
			{
				MessagePlayer("[#FFDD33]Information:[#FFFFFF] Player: "+pcol(plr.ID)+plr.Name+white+" Level: "+status[plr.ID].Level+" ("+checklvl(status[plr.ID].Level)+").", player);
			}
		}
	}
	
	else if(cmd == "lastjoined")
	{
		if(!arguments)
		{
			local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(player.Name.tolower())+"'");
			if(GetSQLColumnData(q, 13) == null) MessagePlayer("[#FF0000]Error:[#FFFFFF] Player: "+playerName+" joined the server first time.", player);
			else MessagePlayer("[#FFDD33]Information:[#FFFFFF] Player: "+playerName+" Last Joined on: "+GetSQLColumnData(q, 13)+".", player);
		}
		else
		{
			local plr = FindPlayer(arguments);
			if(!plr)
			{
				local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(arguments.tolower())+"'");
				if(!q) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
				else
				{
					MessagePlayer("[#FFDD33]Information:[#FFFFFF] Player: [#D3D3D3]"+GetSQLColumnData(q, 0)+white+" Last Joined on: "+GetSQLColumnData(q, 13)+".", player);
				}
			}
			else
			{
				local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(plr.Name.tolower())+"'");	
				if(GetSQLColumnData(q, 13) == null) MessagePlayer("[#FF0000]Error:[#FFFFFF] Player: "+pcol(plr.ID)+plr.Name+white+" joined the server first time.", player);
				else MessagePlayer("[#FFDD33]Information:[#FFFFFF] Player: "+pcol(plr.ID)+plr.Name+white+" Last Joined on: "+GetSQLColumnData(q, 13)+".", player);
			}
		}
	}
	else if(cmd == "getaccinfo" || cmd == "getaccountinfo")
	{
		if(status[player.ID].Level < 6) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <player>", player);
		else
		{
			local plr = FindPlayer(arguments);
			if(plr)
			{
				local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(plr.Name.tolower())+"'");
				if(!q) MessagePlayer("[#FF0000]Error:[#FFFFFF] Player is not registered.", player)
				else
				{
					MessagePlayer("[#FFDD33]Information:[#FFFFFF] Player: "+pcol(plr.ID)+plr.Name+white+" Account Information:", player);
					MessagePlayer(white+"Name: "+GetSQLColumnData(q, 0)+"  Lower Name: "+GetSQLColumnData(q, 1), player);
					MessagePlayer(white+"Level: "+GetSQLColumnData(q, 3)+" ("+checklvl(GetSQLColumnData(q, 3).tointeger())+")", player);
					MessagePlayer(white+"Time Registered: "+GetSQLColumnData(q, 4), player);
					MessagePlayer(white+"UID: "+GetSQLColumnData(q, 5)+"   IP: "+GetSQLColumnData(q, 6), player);
					MessagePlayer(white+"Kills: "+GetSQLColumnData(q, 10)+"  Headshots: "+GetSQLColumnData(q, 11)+"  Deaths: "+GetSQLColumnData(q, 12), player);
					MessagePlayer(white+"Clan: "+GetSQLColumnData(q, 9), player);
					MessagePlayer(white+"Banned: "+GetSQLColumnData(q, 8)+"  Last Joined: "+GetSQLColumnData(q, 13), player);
					MessagePlayer(white+"Ping: "+plr.Ping+"  FPS: "+plr.FPS, player);
				}
			}
			else
			{
				local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(arguments.tolower())+"'");
				if(!q) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
				else
				{
					MessagePlayer("[#FFDD33]Information:[#FFFFFF] Player: [#D3D3D3]"+GetSQLColumnData(q, 0)+white+" Account Information:", player);
					MessagePlayer(white+"Name: "+GetSQLColumnData(q, 0)+"  Lower Name: "+GetSQLColumnData(q, 1), player);
					MessagePlayer(white+"Level: "+GetSQLColumnData(q, 3)+" ("+checklvl(GetSQLColumnData(q, 3).tointeger())+")", player);
					MessagePlayer(white+"Time Registered: "+GetSQLColumnData(q, 4), player);
					MessagePlayer(white+"UID: "+GetSQLColumnData(q, 5)+"   IP: "+GetSQLColumnData(q, 6), player);
					MessagePlayer(white+"Kills: "+GetSQLColumnData(q, 10)+"  Headshots: "+GetSQLColumnData(q, 11)+"  Deaths: "+GetSQLColumnData(q, 12), player);
					MessagePlayer(white+"Clan: "+GetSQLColumnData(q, 9), player);
					MessagePlayer(white+"Banned: "+GetSQLColumnData(q, 8)+"  Last Joined: "+GetSQLColumnData(q, 13), player);
				}
			}
		}
	}
	else if(cmd == "alias")
	{
		if(status[player.ID].Level < 6) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <player>", player);
		else
		{
			local plr = FindPlayer(arguments);
			if(plr)
			{
				local a = "", b = "", c = ""; 
				local q = QuerySQL(DB, "SELECT * FROM Accounts");
				while(GetSQLColumnData(q, 0))
				{
					if(GetSQLColumnData(q, 6) == plr.IP && GetSQLColumnData(q, 5) == plr.UID)
					{
						if(a == "") a = GetSQLColumnData(q, 0);
						else a = a+", "+GetSQLColumnData(q, 0);
					}
					if(GetSQLColumnData(q, 6) != plr.IP && GetSQLColumnData(q, 5) == plr.UID)
					{
						if(b == "") b = GetSQLColumnData(q, 0);
						else b = b+", "+GetSQLColumnData(q, 0);
					}
					if(GetSQLColumnData(q, 6) == plr.IP && GetSQLColumnData(q, 5) != plr.UID)
					{
						if(c == "") c = GetSQLColumnData(q, 0);
						else c = c+", "+GetSQLColumnData(q, 0);
					}
					GetSQLNextRow(q);
				}
				MessagePlayer("[#FFDD33]Information:[#FFFFFF] Player: "+pcol(plr.ID)+plr.Name+white+" Alias:", player);
				MessagePlayer(white+"Same IP from Same Computer: "+a, player);
				MessagePlayer(white+"Different IP from Same Computer: "+b, player);
				MessagePlayer(white+"Same IP from Different Computer: "+c, player);
			}
			else
			{
				local q2 = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(arguments.tolower())+"'");
				if(!q2) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
				else
				{
					local a = "", b = "", c = ""; 
					local q = QuerySQL(DB, "SELECT * FROM Accounts");
					while(GetSQLColumnData(q, 0))
					{
						if(GetSQLColumnData(q, 6) == GetSQLColumnData(q2, 6) && GetSQLColumnData(q, 5) == GetSQLColumnData(q2, 5))
						{
							if(a == "") a = GetSQLColumnData(q, 0);
							else a = a+", "+GetSQLColumnData(q, 0);
						}
						if(GetSQLColumnData(q, 6) != GetSQLColumnData(q2, 6) && GetSQLColumnData(q, 5) == GetSQLColumnData(q2, 5))
						{
							if(b == "") b = GetSQLColumnData(q, 0);
							else b = b+", "+GetSQLColumnData(q, 0);
						}
						if(GetSQLColumnData(q, 6) == GetSQLColumnData(q2, 6) && GetSQLColumnData(q, 5) != GetSQLColumnData(q2, 5))
						{
							if(c == "") c = GetSQLColumnData(q, 0);
							else c = c+", "+GetSQLColumnData(q, 0);
						}
						GetSQLNextRow(q);
					}
					MessagePlayer("[#FFDD33]Information:[#FFFFFF] Player: [#D3D3D3]"+GetSQLColumnData(q2, 0)+white+" Alias:", player);
					MessagePlayer(white+"Same IP from Same Computer: "+a, player);
					MessagePlayer(white+"Different IP from Same Computer: "+b, player);
					MessagePlayer(white+"Same IP from Different Computer: "+c, player);
				}
			}
		}
	}
	else if(cmd == "clanchat" || cmd == "cc")
	{
		if(!arguments) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <text>", player);
		else if(status[player.ID].clan == null) MessagePlayer("[#FF0000]Error:[#FFFFFF] You are not in a clan.", player);
		else
		{
			for(local i = 0; i<= GetMaxPlayers(); i++)
			{
				local plr = FindPlayer(i);
				if(plr && status[plr.ID].clan == status[player.ID].clan) MessagePlayer("[#33DD33][CLAN CHAT] [#FFFFFF]"+playerName+": "+arguments, plr);
			}
		}
	}
	else if(cmd == "teamchat")
	{
		if(!arguments) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <text>", player);
		else
		{
			for(local i = 0; i<= GetMaxPlayers(); i++)
			{
				local plr = FindPlayer(i);
				if(plr && plr.Team == player.Team) MessagePlayer("[#CC33CC][TEAM CHAT] [#FFFFFF]"+playerName+": "+arguments, plr);
			}
		}
	}

	else if (cmd == "adminchat" || cmd == "adminschat" || cmd == "ac" )
	{
		if(status[player.ID].Level < 5) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /" + bas+cmd + " <text>", player);
		else
		{
			local plr;
			for( local i = 0; i <= GetMaxPlayers(); i++ )
			{
				plr = FindPlayer( i );
				if ( ( plr ) && ( status[ plr.ID ].Level >= 5 ) )
				{
					MessagePlayer("[#7B09C6][Admin Chat]: " + playerName + ": " + arguments + ".", plr);
				}
			}
		}
	}


	
	else if(cmd == "nameban")
	{
		if(status[player.ID].Level < 6) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments || NumTok(arguments, " ") < 2) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <player> <reason>", player);
		else
		{
			local now = date();
			local dat = now.day + "/" + now.month + "/" + now.year + " " + now.hour + ":" + now.min + ":" + now.sec;
			local plr = FindPlayer(GetTok(arguments, " ", 2));
			if(plr)
			{
				QuerySQL(ban, "INSERT INTO nameban (name, admin, date, reason) VALUES ('"+escapeSQLString(plr.Name.tolower())+"', '"+escapeSQLString(player.Name.tolower())+"', '"+dat+"', '"+GetTok(arguments, " ", 2, NumTok(arguments, " "))+"') ");
				local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(plr.Name.tolower())+"'");
				if(q) QuerySQL(DB, "UPDATE Accounts SET banned = 'Yes' WHERE LowerName = '"+escapeSQLString(plr.Name.tolower())+"'");
				Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" Name-Banned player: "+pcol(plr.ID)+plr.Name+white+" Reason: "+GetTok(arguments, " ", 2, NumTok(arguments, " "))+".");
				MessagePlayer("[#FFDD33]Information:[#FFFFFF] If you think that you are wrongfully banned, make an admin report on our forum: ", plr);
				KickPlayer(plr);
			}
			else
			{
				QuerySQL(ban, "INSERT INTO nameban (name, admin, date, reason) VALUES ('"+escapeSQLString(GetTok(arguments, " ", 1).tolower())+"', '"+escapeSQLString(player.Name.tolower())+"', '"+dat+"', '"+GetTok(arguments, " ", 2, NumTok(arguments, " "))+"') ");
				local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(GetTok(arguments, " ", 1).tolower())+"'");
				if(q)
				{
					QuerySQL(DB, "UPDATE Accounts SET banned = 'Yes' WHERE LowerName = '"+escapeSQLString(GetTok(arguments, " ", 1).tolower())+"'");
					Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" Name-Banned player: [#D3D3D3]"+GetSQLColumnData(q, 0)+white+" Reason: "+GetTok(arguments, " ", 2, NumTok(arguments, " "))+".");
				}
				else Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" Name-Banned player: [#D3D3D3]"+GetTok(arguments, " ", 1)+white+" Reason: "+GetTok(arguments, " ", 2, NumTok(arguments, " "))+".");

			}
		}
	}
	
	else if(cmd == "permaban")
	{
		if(status[player.ID].Level < 6) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments || NumTok(arguments, " ") < 2) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <player> <reason>", player);
		else
		{
			local now = date();
			local dat = now.day + "/" + now.month + "/" + now.year + " " + now.hour + ":" + now.min + ":" + now.sec;
			local plr = FindPlayer(GetTok(arguments, " ", 2));
			if(plr)
			{
				QuerySQL(ban, "INSERT INTO permaban (name, admin, date, UID, reason) VALUES ('"+escapeSQLString(plr.Name.tolower())+"', '"+escapeSQLString(player.Name.tolower())+"', '"+dat+"', '"+plr.UID+"', '"+GetTok(arguments, " ", 2, NumTok(arguments, " "))+"') ");
				local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(plr.Name.tolower())+"'");
				if(q) QuerySQL(DB, "UPDATE Accounts SET banned = 'Yes' WHERE LowerName = '"+escapeSQLString(plr.Name.tolower())+"'");
				Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" Permanently Banned player: "+pcol(plr.ID)+plr.Name+white+" Reason: "+GetTok(arguments, " ", 2, NumTok(arguments, " "))+".");
				MessagePlayer("[#FFDD33]Information:[#FFFFFF] If you think that you are wrongfully banned, make an admin report on our forum: ", plr);
				local uid = plr.UID;
				KickPlayer(plr);
				for(local i=0; i<=GetMaxPlayers(); i++)
				{
					local plar = FindPlayer(i);
					if(plar && plar.UID == uid) KickPlayer(plar);
				}
			}
			else
			{
				local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(GetTok(arguments, " ", 2).tolower())+"'");
				if(q)
				{
					QuerySQL(ban, "INSERT INTO permaban (name, admin, date, UID, reason) VALUES ('"+escapeSQLString(GetSQLColumnData(q, 1).tolower())+"', '"+escapeSQLString(player.Name.tolower())+"', '"+dat+"', '"+GetSQLColumnData(q, 5)+"', '"+GetTok(arguments, " ", 2, NumTok(arguments, " "))+"') ");
					QuerySQL(DB, "UPDATE Accounts SET banned = 'Yes' WHERE LowerName = '"+escapeSQLString(GetSQLColumnData(q, 1).tolower())+"'");
					MessagePlayer("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" Permanently Banned player: [#D3D3D3]"+GetSQLColumnData(q, 0)+" Reason: "+GetTok(arguments, " ", 2, NumTok(arguments, " "))+".", player);
					QuerySQL(DB, "UPDATE Accounts SET banned = 'Yes' WHERE LowerName = '"+escapeSQLString(GetTok(arguments, " ", 1).tolower())+"'");
					local uid = GetSQLColumnData(q, 6);
					for(local i=0; i<=GetMaxPlayers(); i++)
					{
						local plar = FindPlayer(i);
						if(plar && plar.UID == uid) KickPlayer(plar);
					}
				}
				else
				{
				
					local q2 = QuerySQL(DB, "SELECT * FROM Unregistered WHERE LowerName = '"+escapeSQLString(GetTok(arguments, " ", 2).tolower())+"'");
					if(!q2) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
					else
					{
						QuerySQL(ban, "INSERT INTO permaban (name, admin, date, UID, reason) VALUES ('"+escapeSQLString(GetSQLColumnData(q2, 1).tolower())+"', '"+escapeSQLString(player.Name.tolower())+"', '"+dat+"', '"+GetSQLColumnData(q, 5)+"', '"+GetTok(arguments, " ", 2, NumTok(arguments, " "))+"') ");
						MessagePlayer("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" Permanently Banned player: [#D3D3D3]"+GetSQLColumnData(q, 0)+" Reason: "+GetTok(arguments, " ", 2, NumTok(arguments, " "))+".", player);
						local uid = GetSQLColumnData(q, 6);
						for(local i=0; i<=GetMaxPlayers(); i++)
						{
							local plar = FindPlayer(i);
							if(plar && plar.UID == uid) KickPlayer(plar);
						}
					}
				}
			}
		}
	}
	else if(cmd == "tempban")
	{
		if(status[player.ID].Level < 6) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments || NumTok(arguments, " ") < 3) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <player> <days 1 - 100> <reason>", player);
		else if(!IsNum(GetTok(arguments, " ", 2)) || GetTok(arguments, " ", 2).tointeger() < 0 || GetTok(arguments, " ", 2).tointeger() > 100) MessagePlayer("[#FF0000]Error:[#FFFFFF] Days should be in numbers and between 1 to 100.", player);
		else
		{
			local now = date();
			local dat = now.day + "/" + now.month + "/" + now.year + " " + now.hour + ":" + now.min + ":" + now.sec;
			local plr = FindPlayer(GetTok(arguments, " ", 1));
			if(plr)
			{
				QuerySQL(ban, "INSERT INTO tempban (name, admin, date, UID, duration, expire, reason) VALUES ('"+escapeSQLString(plr.Name.tolower())+"', '"+escapeSQLString(player.Name.tolower())+"', '"+dat+"', '"+plr.UID+"', '"+GetTok(arguments, " ", 2)+"', '"+addbantime(GetTok(arguments, " ", 2).tointeger())+"', '"+GetTok(arguments, " ", 3, NumTok(arguments, " "))+"') ");
				local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(plr.Name.tolower())+"'");
				if(q) 
				QuerySQL(DB, "UPDATE Accounts SET banned = 'Yes' WHERE LowerName = '"+escapeSQLString(plr.Name.tolower())+"'");
				Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" Banned player: "+pcol(plr.ID)+plr.Name+white+" for: "+GetTok(arguments, " ", 2)+" days Reason: "+GetTok(arguments, " ", 3, NumTok(arguments, " "))+".");
				MessagePlayer("[#FFDD33]Information:[#FFFFFF] If you think that you are wrongfully banned, make an admin report on our forum: ", plr);
				local uid = plr.UID;
				KickPlayer(plr);
				for(local i=0; i<=GetMaxPlayers(); i++)
				{
					local plar = FindPlayer(i);
					if(plar && plar.UID == uid) KickPlayer(plar);
				}
			}
			else
			{
				local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(GetTok(arguments, " ", 1).tolower())+"'");
				if(!q) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
				else
				{
					QuerySQL(ban, "INSERT INTO tempban (name, admin, date, UID, duration, expire, reason) VALUES ('"+escapeSQLString(GetTok(arguments, " ", 2).tolower())+"', '"+escapeSQLString(player.Name.tolower())+"', '"+dat+"', '"+GetSQLColumnData(q, 6)+"', '"+GetTok(arguments, " ", 2)+"', '"+addbantime(GetTok(arguments, " ", 2).tointeger())+"', '"+GetTok(arguments, " ", 3, NumTok(arguments, " "))+"') ");
					QuerySQL(DB, "UPDATE Accounts SET banned = 'Yes' WHERE LowerName = '"+escapeSQLString(GetTok(arguments, " ", 1).tolower())+"'");
					Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" Banned player: [#D3D3D3]"+GetSQLColumnData(q, 0)+white+" for: "+GetTok(arguments, " ", 2)+" days Reason: "+GetTok(arguments, " ", 2, NumTok(arguments, " "))+".");
					local uid = GetSQLColumnData(q, 6);
					for(local i=0; i<=GetMaxPlayers(); i++)
					{
						local plar = FindPlayer(i);
						if(plar && plar.UID == uid) KickPlayer(plar);
					}
				}
			}
		}
	}
	
	else if(cmd == "permaunban")
	{
		if(status[player.ID].Level < 6) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <player>", player);
		else
		{
			local q = QuerySQL(ban, "SELECT * FROM permaban WHERE name = '"+escapeSQLString(arguments.tolower())+"'");
			if(!q) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
			else
			{
				Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" unbanned player: "+GetSQLColumnData(q, 0)+"'");
				QuerySQL(ban, "INSERT INTO permaunban (name, badmin, admin, date, breason) VALUES ('"+GetSQLColumnData(q, 0)+"', '"+GetSQLColumnData(q, 1)+"', '"+player.Name+"', '"+GetSQLColumnData(q, 2)+"', '"+GetSQLColumnData(q, 4)+"') ");
				QuerySQL(ban, "DELETE FROM permaban WHERE name = '"+escapeSQLString(arguments.tolower())+"'");
				if(q) QuerySQL(DB, "UPDATE Accounts SET Banned = 'No' WHERE LowerName = '"+escapeSQLString(arguments.tolower())+"'");
			}
		}
	}
	else if(cmd == "tempunban")
	{
		if(status[player.ID].Level < 6) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <player>", player);
		else
		{
			local q = QuerySQL(ban, "SELECT * FROM permaban WHERE name = '"+escapeSQLString(arguments.tolower())+"'");
			if(!q) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
			else
			{
				Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" unbanned player: "+GetSQLColumnData(q, 0)+"'");
				QuerySQL(ban, "INSERT INTO temunbanned (name, badmin, admin, duration, date, breason) VALUES ('"+GetSQLColumnData(q, 0)+"', '"+GetSQLColumnData(q, 1)+"', '"+escapeSQLString(player.Name)+"', '"+GetSQLColumnData(q, 4)+"', '"+GetSQLColumnData(q, 2)+"', '"+GetSQLColumnData(q, 6)+"') ");
				QuerySQL(ban, "DELETE FROM tempban WHERE name = '"+escapeSQLString(arguments.tolower())+"'");
				if(q) QuerySQL(DB, "UPDATE Accounts SET Banned = 'No' WHERE LowerName = '"+escapeSQLString(arguments.tolower())+"'");
			}
		}
	}
	else if(cmd == "nameunban")
	{
		if(status[player.ID].Level < 6) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <player>", player);
		else
		{
			local q = QuerySQL(ban, "SELECT * FROM nameban WHERE name = '"+escapeSQLString(arguments.tolower())+"'");
			if(!q) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
			else
			{
				Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" name-unbanned player: [#D3D3D3]"+GetSQLColumnData(q, 0)+white+".");
				QuerySQL(ban, "INSERT INTO nameunban (name, badmin, admin, date, breason) VALUES ('"+GetSQLColumnData(q, 0)+"', '"+GetSQLColumnData(q, 1)+"', '"+player.Name+"', '"+GetSQLColumnData(q, 2)+"', '"+GetSQLColumnData(q, 3)+"') ");
				QuerySQL(ban, "DELETE FROM nameban WHERE name = '"+escapeSQLString(arguments.tolower())+"'");
				QuerySQL(DB, "UPDATE Accounts SET Banned = 'No' WHERE LowerName = '"+escapeSQLString(arguments.tolower())+"'");
			}
		}
	}
	else if(cmd == "time")
	{
		local now = date();
		local dat = now.day + "/" + now.month + "/" + now.year + " " + now.hour + ":" + now.min + ":" + now.sec;
		MessagePlayer("[#FFDD33]Information:[#FFFFFF] The Time is: "+dat, player);
	}
	else if(cmd == "spree")
	{
		if(!arguments) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Current Spree: "+status[player.ID].spree+".", player);
		else
		{
			local plr = FindPlayer(arguments);
			if(!plr) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
			else MessagePlayer("[#FFDD33]Information:[#FFFFFF] Player: "+pcol(plr.ID)+plr.Name+white+" Spree: "+status[plr.ID].spree+".", player);
		}
	}
	else if(cmd == "playeronspree" || cmd == "playersonspree" || cmd == "onspree")
	{
		local b=0;
		for(local i=0; i<=GetMaxPlayers();i++)
		{
			local plr = FindPlayer(i);
			if(plr && status[plr.ID].spree > 4)
			{
				if(b == 0) b = pcol(plr.ID)+plr.Name+white+"("+status[plr.ID].spree+")";
				else b = b+", "+pcol(plr.ID)+plr.Name+white+"("+status[plr.ID].spree+")";
			}
		}
		if(b == 0) Message("[#FFDD33]Information:[#FFFFFF] No player's currently on spree.");
		else Message("[#FFDD33]Information:[#FFFFFF] Player's on spree: "+b);
	}
	else if(cmd == "setspree")
	{
		if(status[player.ID].Level < 5) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments || NumTok(arguments, " ") < 2) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <player> <number>", player);
		else if(!IsNum(GetTok(arguments, " ", 2)) || GetTok(arguments, " ", 2).tointeger() < 0) MessagePlayer("[#FF0000]Error:[#FFFFFF] Wrong Number entered.", player);
		else
		{
			local plr = FindPlayer(GetTok(arguments, " ", 1));
			if(!plr) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
			else
			{
				status[plr.ID].spree = GetTok(arguments, " ", 2).tointeger();
				Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" set spree of player: "+pcol(plr.ID)+plr.Name+white+" to: "+GetTok(arguments, " ", 2)+".");
			}
		}
	}
	else if(cmd == "setpass" || cmd == "setpassword")
	{
		if(status[player.ID].Level < 6) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments || NumTok(arguments, " ") < 2) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <player name> <passoword>", player);
		else if(GetTok(arguments, " ", 2).len() < 4) MessagePlayer("[#FF0000]Error:[#FFFFFF] Password should be longer than 4 characters.", player);
		{
			local plr = FindPlayer(GetTok(arguments, " ", 2));
			if(plr)
			{
				status[plr.ID].pass = SHA256(GetTok(arguments, " ", 2));
				QuerySQL(DB, "UPDATE Accounts SET Password = '"+status[plr.ID].pass+"' WHERE LowerName = '"+escapeSQLString(plr.Name.tolower())+"'");
				MessagePlayer("[#FFDD33]Information:[#FFFFFF] Your password has been updated  by Admin :"+playerName+".", plr);
				MessagePlayer("[#FFDD00]Administrator Command:[#FFFFFF] You changed Password of player: "+pcol(plr.ID)+plr.Name+white+".", player);
			}
			else
			{
				local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+GetTok(arguments, " ", 1)+"'");
				if(!q) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
				else
				{
					QuerySQL(DB, "UPDATE Accounts SET Password = '"+GetTok(arguments, " ", 2)+"' WHERE LowerName = '"+escapeSQLString(GetTok(arguments, " ", 2).tolower())+"'");
					MessagePlayer("[#FFDD00]Administrator Command:[#FFFFFF] You changed Password of player: [#D3D3D3]"+GetSQLColumnData(q, 0)+white+".", player);
				}
			}
		}
	}
	else if(cmd == "cmds" || cmd == "commands")
	{
		if(!arguments || !IsNum(arguments) || arguments.tointeger() < 0 || arguments.tointeger() > 3) MessagePlayer("[#FF0000]Error:[#FFFFFF] USe /"+bas+cmd+" <1-3>", player);
		else
		{
			if(arguments.tointeger() == 1) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Account Commands:"+bas+" register, login, changepass, level, clan, lastjoined, clanchat, teamchat",player);
			else if(arguments.tointeger() == 2) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Fighting Commands:"+bas+" wep, spawnwep, spree, playersonspree", player);
		}
	}
	
	else if(cmd == "refreecmds")
	{
		if(status[player.ID].Level < 4) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else
		{
			MessagePlayer("[#FFDD33]Information:[#FFFFFF] Refree Commands:"+bas+" ", player);
		}
	}
	else if(cmd == "acmds" || cmd == "admincommands")
	{
		if(status[player.ID].Level < 5) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else
		{
			MessagePlayer("[#FFDD33]Information:[#FFFFFF] Admin Commands:"+bas+" slap, warn, kick, sethp, canattack, setattack, setspawnattack ", player);
			if(status[player.ID].Level > 5) MessagePlayer(white+"Founder Commands:"+bas+" setrefree, setadmin, addclan, removeclan, addclanmember, removeclanmember, getaccinfo, alias, setpass ", player);
			if(status[player.ID].Level > 5) MessagePlayer(white+"Ban Commands:"+bas+" nameban, nameunban, permaban, permaunban, tempban, tempunban ", player);
		}
	}
	else MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Command. Use /"+bas+"cmds"+white+" for a list of Commands", player);
}

}