class PlayerStats
{
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
}

const white = "[#FFFFFF]";
const bas = "[#FFDD33]";
function onScriptLoad()
{
 DB <- ConnectSQL("databases/Registration.db");
 QuerySQL(DB, "CREATE TABLE if not exists Accounts ( Name TEXT, LowerName TEXT, Password VARCHAR ( 255 ), Level NUMERIC DEFAULT 1, TimeRegistered VARCHAR ( 255 ) DEFAULT CURRENT_TIMESTAMP, UID VARCHAR ( 255 ), IP VARCHAR ( 255 ), AutoLogin BOOLEAN DEFAULT true, Banned TEXT, clan VARCHAR ( 255 ), Kills VARCHAR ( 255 ), Headshots VARCHAR ( 255 ), Deaths VARCHAR ( 255 ) ) ");
 print("Registeration System Loaded");
}

function onScriptUnload()
{
}


function onPlayerJoin( player )
{
	status[player.ID] = PlayerStats();

}


function AccInfo(player)
{
 local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE Name = '" + escapeSQLString(player.Name) + "'");
 local q2 = QuerySQL(DB, "SELECT * FROM Stats WHERE Name = '" + escapeSQLString(player.Name) + "'");

 if (q)
 {
  status[player.ID].Level = GetSQLColumnData(q, 3);
  status[player.ID].UID = GetSQLColumnData(q, 5);
  status[player.ID].IP = GetSQLColumnData(q, 6);
  status[player.ID].AutoLogin = GetSQLColumnData(q, 7);
  status[player.ID].Registered = true;
  status[player.ID].banned = GetSQLColumnData(q, 8);
  status[player.ID].clan = GetSQLColumnData(q, 9);
  status[player.iD].kills = GetSQLColumnData(q, 10);
  status[player.iD].headsots = GetSQLColumnData(q, 11);
  status[player.iD].deaths = GetSQLColumnData(q, 12);
 if ((player.UID == status[player.ID].UID) || (player.IP == status[player.ID].IP))
  {
	if(status[player.ID].banned == "Yes")
	{
		Announce("~y~Banned", 8, player);
		MessagePlayer("[#FFDD33]Information:[#FFFFFF] You are banned from the server", player);
		Message("[#FFDD33]Information:[#FFFFFF] Player : " + player.Name + " Kicked from server Reason : Banned From Server.");
		KickPlayer(player);
	} 
 else
 { 
 if (status[player.ID].AutoLogin == "true")
   {
    MessagePlayer("[#FFDD33] Welcome back to the [#FFFF00]Next Generation's(DM) server[#FFFFFF].", player);
	if(status[player.ID].clan != null)
	{
		MessagePlayer("[#FFDD33] Clan : "+status[player.ID].clan+".", player);
	}
    MessagePlayer("[#FFDD33] You've been auto logged in, to disable this, type /autologin [ Toggles automatically ]", player);
    status[player.ID].LoggedIn = true;
   }
   else
   {
    MessagePlayer("[#FFDD33] Welcome back to the [#FFFF00]VCMP Clan Tournament 2018[#FFFFFF].", player);
    MessagePlayer("[#FFDD33] Your nick is registered. Please login in order to access services.", player);
   }
  }
  }
  else
  {
    MessagePlayer("[#FFDD33] Welcome back to the [#FFFF00]VCMP Clan Tournament 2018[#FFFFFF].", player);
   MessagePlayer("[#FFDD33] Your nick is registered. Please login in order to access services.", player);
  }
 }
 else
 {
    MessagePlayer("[#FFDD33] Welcome back to the [#FFFF00]VCMP Clan Tournament 2018[#FFFFFF].", player);
  MessagePlayer("[#FFDD33] Your nick is [#FF0000]not [#FFDD33]registered. Please register in order to access services.", player);
 }
//  FreeSQLQuery(q);
}



function onPlayerPart( player, reason )
{
}

function onPlayerRequestClass( player, classID, team, skin )
{
	return 1;
}

function onPlayerRequestSpawn( player )
{
	return 1;
}

function onPlayerSpawn( player )
{
}

function onPlayerDeath( player, reason )
{
}

function onPlayerKill( player, killer, reason, bodypart )
{
}

function onPlayerTeamKill( player, killer, reason, bodypart )
{
}

function onPlayerChat( player, text )
{
}

function onPlayerCommand( player, cmd, text )
{
local cmd, text;
cmd = command.tolower();
text = arguments;
local params;

	if(cmd == "register")
	{
	
	}



	else MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Command. Use /"+cmd+bas+" for a list of Commands", player);
}
