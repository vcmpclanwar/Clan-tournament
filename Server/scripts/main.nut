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
 QuerySQL(DB, "CREATE TABLE if not exists Accounts ( Name TEXT, LowerName TEXT, Password VARCHAR ( 255 ), Level NUMERIC DEFAULT 1, TimeRegistered VARCHAR ( 255 ) DEFAULT CURRENT_TIMESTAMP, UID VARCHAR ( 255 ), IP VARCHAR ( 255 ), AutoLogin BOOLEAN DEFAULT true, Banned TEXT, clan VARCHAR ( 255 ), Kills VARCHAR ( 255 ), Headshots VARCHAR ( 255 ), Deaths VARCHAR ( 255 ) ) ");
 print("Registeration System Loaded");

 QuerySQL(DB," create table if not exists kicked ( name VARCHAR ( 255 ), admin VARCHAR ( 255 ), date VARCHAR ( 255 ), reason VARCHAR ( 255 ) ) ");
 QuerySQL(DB," create table if not exists warn ( name VARCHAR ( 255 ), admin VARCHAR ( 255 ), date VARCHAR ( 255 ), reason VARCHAR ( 255 ) ) ");
 QuerySQL(DB," create table if not exists slap ( name VARCHAR ( 255 ), admin VARCHAR ( 255 ), date VARCHAR ( 255 ), reason VARCHAR ( 255 ) ) ");
 
 
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
	AccInfo(player);
	MessagePlayer("[#FFDD33]Information:[#FFFFFF] Level: "+status[player.ID].Level+" ("+checklvl(status[player.ID].Level)+")", player);

}


function AccInfo(player)
{
 local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE Name = '" + escapeSQLString(player.Name) + "'");
	if (q)
 {
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
}

function onPlayerKill( player, killer, reason, bodypart )
{
}

function onPlayerTeamKill( player, killer, reason, bodypart )
{
}

function onPlayerChat( player, text )
{
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
		MessagePlayer("[#FFDD33]Information:[#FFFFFF] This Server is created by =FX=UmaR^, Tdz.Kurumi, =FXt=Mohamed.", player);
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

					
					//MessagePlayer("[#FFDD33]Information:[#FFFFFF] You received the following weapon: "+weapons+".", player);
					//status[player.ID].wepcmd = true;
					//NewTimer("wepcmdf", 1000, 1, player.ID);

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
				status[player.ID].Level = 4;
				QuerySQL(DB, "UPDATE Accounts SET Level = '4' WHERE LowerName = '"+escapeSQLString(plr.Name.tolower())+"'");
				Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" changed rank of player: "+pcol(plr.ID)+plr.Name+white+" to: "+checklvl(status[player.ID].Level)+".");
				MessagePlayer("[#FFDD33]Information:[#FFFFFF] Now you are a refree. Type /"+bas+"refreehelp"+white+" to learn about it.", player);
			}
			else
			{
				local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(arguments.tolower())+"'");
				if(!q) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
				else
				{
					Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" set: [#D3D3D3]"+GetSQLColumnData(q, 0)+white+" rank to: "+checklvl(status[player.ID].Level)+".");
					QuerySQL(DB, "UPDATE Accounts SET Level = '4' WHERE LowerName = '"+escapeSQLString(arguments.tolower())+"'");
				}
			}
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	else if(cmd == "cmds" || cmd == "commands")
	{
		if(!arguments || !IsNum(arguments) || arguments.tointeger() < 0 || arguments.tointeger() > 3) MessagePlayer("[#FF0000]Error:[#FFFFFF] USe /"+bas+cmd+" <1-3>", player);
		else
		{
			if(arguments.tointeger() == 1) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Account Commands:"+bas+" register, login, changepass",player);
			else if(arguments.tointeger() == 2) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Fighting Commands:"+bas+" wep, spawnwep", player);
		}
	}
	
	else if(cmd == "acmds" || cmd == "admincommands")
	{
		if(status[player.ID].Level < 5) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else
		{
			MessagePlayer("[#FFDD33]Information:[#FFFFFF] Admin Commands:"+bas+" slap, warn, kick, sethp, canattack, setattack, setspawnattack ", player);
			if(status[player.ID].Level > 5) MessagePlayer("Founder Commands:"+bas+" unwarn(not added), setrefree(not added), addclan(not added), addclanmember(not added) ", player);
		}
	}
	else MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Command. Use /"+bas+"cmds"+white+" for a list of Commands", player);
}

}