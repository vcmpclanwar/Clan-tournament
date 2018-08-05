function Server::ServerData(stream)
{
	local StreamReadInt = stream.ReadInt(),
	StreamReadString = stream.ReadString();
	switch (StreamReadInt.tointeger())
	{
		case 1:
			GGstart(StreamReadString);
		break;
		case 2:
			GGupdate(StreamReadString);
		break;
		case 3:
			GGremove();
		break;
		case 4:
			FRtarget(StreamReadString);
		break;
		case 5:
			FRremove();
		break;
		case 6:
			FRupdatetime();
		break;
		case 7:
			FRsettime(StreamReadString);
		break;
        case 8:
        if( StreamReadString != "null" )
        {
            local params = split( StreamReadString, "," ), clann = params[0], clann2 = params[1], clans = params[2], clans2 = params[3], r = params[4], cp1 = params[5], cp2 = params[6], cs1 = params[7], cs2 = params[8];
            ::ClanName = clann;
            ::ClanName2 = clann2;
            ::ClanScore1 = clans;
            ::ClanScore2 = clans2;
            ::Round = r;
            ::ClanPlayers1 = cp1;
            ::ClanPlayers2 = cp2;
            ::Subs1 = cs1;
            ::Subs2 = cs2;
            //Console.Print( "[Clan Battle] Clan Name: "+ clann +" | Clan Name 2: "+ clann2 +" | Score: "+clans+":"+clans2+" | Round: "+r+" | Clan Players: "+ cp1 +" | Clan Players 2: "+ cp2 +" | Subs 1: "+ cs1 +" | Subs 2: "+ cs2 +"" );
        }
        else
        {
            ::ClanName = null;
            ::ClanName2 = null;
            ::ClanScore1 = 0;
            ::ClanScore2 = 0;
            ::Round = 0;
            ::ClanPlayers1 = null;
            ::ClanPlayers2 = null;
            ::Subs1 = null;
            ::Subs2 = null;
            //Console.Print( "[Clan Battle] Variables cleared." );
        }
        break;
        case 9:
        if( StreamReadString != "null" ) CBRoundScreen( StreamReadString );
        else RemoveCBScoreboardDisplay();  
        break;
        case 10:
           
        break;
    }
}

function Script::ScriptProcess()
{
	Timer.Process();
}
/* function Script::ScriptLoad()
{
 local hash = Timer.Create(this, function(text, int) {
  Console.Print(text + int);
 }, 1000, 0, "Timer Text ", 12345);
 Console.Print(hash);
}
*/
Timer <- {
 Timers = {}

 function Create(environment, listener, interval, repeat, ...)
 {
  // Prepare the arguments pack
  vargv.insert(0, environment);

  // Store timer information into a table
  local TimerInfo = {
   Environment = environment,
   Listener = listener,
   Interval = interval,
   Repeat = repeat,
   Args = vargv,
   LastCall = Script.GetTicks(),
   CallCount = 0
  };

  local hash = split(TimerInfo.tostring(), ":")[1].slice(3, -1).tointeger(16);
	if(listener == FRupdatetime) FRtimetimer = hash;
  // Store the timer information
  Timers.rawset(hash, TimerInfo);

  // Return the hash that identifies this timer
  return hash;
 }

 function Destroy(hash)
 {
  // See if the specified timer exists
  if (Timers.rawin(hash))
  {
   // Remove the timer information
   Timers.rawdelete(hash);
  }
 }

 function Exists(hash)
 {
  // See if the specified timer exists
  return Timers.rawin(hash);
 }

 function Fetch(hash)
 {
  // Return the timer information
  return Timers.rawget(hash);
 }

 function Clear()
 {
  // Clear existing timers
  Timers.clear();
 }

 function Process()
 {
  local CurrTime = Script.GetTicks();
  foreach (hash, tm in Timers)
  {
   if (tm != null)
   {
    if (CurrTime - tm.LastCall >= tm.Interval)
    {
     tm.CallCount++;
     tm.LastCall = CurrTime;

     tm.Listener.pacall(tm.Args);

     if (tm.Repeat != 0 && tm.CallCount >= tm.Repeat)
      Timers.rawdelete(hash);
    }
   }
  }
 }
};


GGscore <-
{
 plr = null
 plr2 = null
 plr3 = null
 plr4= null
 plr5 = null
 score = null
 score2 = null
 score3 = null
 score4 = null
 score5 = null
}

Scoreboard <-
{
 Label = null

}
FRtt <-
{
 tname = null
 min = null
 col = null
 sec = null
 target = null
 name = null
}
function GGremove()
{
	Scoreboard.Label = null;
	GGscore.plr = null;
	GGscore.plr = null;
	GGscore.plr2 = null;
	GGscore.plr3 = null;
	GGscore.plr4= null;
	GGscore.plr5 = null;
	GGscore.score = null;
	GGscore.score2 = null;
	GGscore.score3 = null;
	GGscore.score4 = null;
	GGscore.score5 = null;
}

screen <- GUI.GetScreenSize();
function GGstart(strread)
{
	Scoreboard.Label = GUILabel(VectorScreen((screen.X * 0.80), (screen.Y * 0.40)), Colour(235, 0, 0), "Scoreboard : " + strread);
	Scoreboard.Label.FontSize = 12;
	Scoreboard.Label.FontFlags = GUI_FFLAG_BOLD;

	GGscore.plr = GUILabel(VectorScreen((screen.X * 0.80), (screen.Y * 0.43)), Colour(255, 255, 255), "null : 0");
	GGscore.plr.FontSize = 11;

	GGscore.plr2 = GUILabel(VectorScreen((screen.X * 0.80), (screen.Y * 0.45)), Colour(255, 255, 255), "null : 0");
	GGscore.plr2.FontSize = 11;

	GGscore.plr3 = GUILabel(VectorScreen((screen.X * 0.80), (screen.Y * 0.47)), Colour(255, 255, 255), "null : 0");
	GGscore.plr3.FontSize = 11;

	GGscore.plr4 = GUILabel(VectorScreen((screen.X * 0.80), (screen.Y * 0.49)), Colour(255, 255, 255), "null : 0");
	GGscore.plr4.FontSize = 11;

	GGscore.plr5 = GUILabel(VectorScreen((screen.X * 0.80), (screen.Y * 0.51)), Colour(255, 255, 255), "null : 0");
	GGscore.plr5.FontSize = 11;


}

function GGupdate(string)
{
	local params = split(string, " "), player = params[0], scr = params[2];
	local p1 = split(GGscore.plr.Text, " "), plar1 = p1[0], score1 = p1[2];
	local p2 = split(GGscore.plr2.Text, " "), plar2 = p2[0], score2 = p2[2];
	local p3 = split(GGscore.plr3.Text, " "), plar3 = p3[0], score3 = p3[2];
	local p4 = split(GGscore.plr4.Text, " "), plar4 = p4[0], score4 = p4[2];
	local p5 = split(GGscore.plr5.Text, " "), plar5 = p5[0], score5 = p5[2];
		if(score1.tointeger() < scr.tointeger())
		{
			if(plar1 == player)
			{
				GGscore.plr.Text = player+" : "+scr;
				
			}
			else if(plar2 == player)
			{
				GGscore.plr2.Text = GGscore.plr.Text;
				GGscore.plr.Text = player+" : "+scr;
				
			}
			else
			{
				GGscore.plr5.Text = GGscore.plr4.Text;
				GGscore.plr4.Text = GGscore.plr3.Text;
				GGscore.plr3.Text = GGscore.plr2.Text;
				GGscore.plr2.Text = GGscore.plr.Text;
				GGscore.plr.Text = player+" : "+scr;
			}
		}
		else if(score2.tointeger() < scr.tointeger())
		{
			if(plar2 == player)
			{
				GGscore.plr2.Text = player+" : "+scr;
				
			}
			else if(plar3 == player)
			{
				GGscore.plr3.Text = GGscore.plr2.Text;
				GGscore.plr2.Text = player+" : "+scr;
				
			}
			else
			{
				GGscore.plr5.Text = GGscore.plr4.Text;
				GGscore.plr4.Text = GGscore.plr3.Text;
				GGscore.plr3.Text = GGscore.plr2.Text;
				GGscore.plr2.Text = player+" : "+scr;
			}
		}
		else if(score3.tointeger() < scr.tointeger())
		{
			if(plar3 == player)
			{
				GGscore.plr3.Text = player+" : "+scr;
				
			}
			else if(plar4 == player)
			{
				GGscore.plr4.Text = GGscore.plr3.Text;
				GGscore.plr3.Text = player+" : "+scr;
				
			}
			else
			{
				GGscore.plr5.Text = GGscore.plr4.Text;
				GGscore.plr4.Text = GGscore.plr3.Text;
				GGscore.plr3.Text = player+" : "+scr;
			}
		}
		else if(score4.tointeger() < scr.tointeger())
		{
			if(plar4 == player)
			{
				GGscore.plr4.Text = player+" : "+scr;
				
			}
			else if(plar5 == player)
			{
				GGscore.plr5.Text = GGscore.plr4.Text;
				GGscore.plr4.Text = player+" : "+scr;
				
			}
			else
			{
				GGscore.plr5.Text = GGscore.plr4.Text;
				GGscore.plr4.Text = player+" : "+scr;
			}
		}
		else if(score5.tointeger() < scr.tointeger())
		{
			GGscore.plr5.Text = player+" : "+scr;
		}
		else return;
}
FRtimetimer <- null;

function FRtarget(strread)
{
	FRtt.target = GUILabel(VectorScreen((screen.X * 0.80), (screen.Y * 0.85)), Colour(235, 0, 0), "Target:");
	FRtt.target.FontSize = 14;
	FRtt.target.FontFlags = GUI_FFLAG_BOLD;
	FRtt.name = GUILabel(VectorScreen((screen.X * 0.86), (screen.Y * 0.85)), Colour(255, 255, 255), strread);
	FRtt.name.FontSize = 14;
	FRtt.name.FontFlags = GUI_FFLAG_BOLD;
	
	FRtt.tname = GUILabel(VectorScreen((screen.X * 0.80), (screen.Y * 0.88)), Colour(235, 0, 0), "Time Left:");
	FRtt.tname.FontFlags = GUI_FFLAG_BOLD;
	FRtt.tname.FontSize = 14;
	
	FRtt.min = GUILabel(VectorScreen((screen.X * 0.865), (screen.Y * 0.883)), Colour(255, 255, 255), "02");
	FRtt.col = GUILabel(VectorScreen((screen.X * 0.875), (screen.Y * 0.883)), Colour(255, 255, 255), ":");
	FRtt.sec = GUILabel(VectorScreen((screen.X * 0.885), (screen.Y * 0.883)), Colour(255, 255, 255), "00");
	FRtt.min.FontSize = 12;
	FRtt.col.FontSize = 12;
	FRtt.sec.FontSize = 12;
	Timer.Create(this, FRupdatetime, 1000, 1000);
	
}
function FRsettime(strread)
{
	local Min = FRtt.min.Text.tofloat();
	local Sec = FRtt.sec.Text.tofloat();
	local add = strread.tofloat();
	
	Sec = Sec + add;
	if(Sec > 60)
	{
		Min++;
		Sec = Sec - 60;
	}
	FRtt.min.Text = Min;
	FRtt.sec.Text = Sec;
	
}

function FRupdatetime()
{
	local Min = FRtt.min.Text.tofloat();
	local Sec = FRtt.sec.Text.tofloat();
	
	Sec = Sec - 1;
	if(Sec <= 0)
	{
		
		if(Min <= 0)
		{
			SendDataToServer("out", 1);
			Timer.Destroy(FRtimetimer);
		}
		else
		{
			Sec = 59;
			Min--;
			FRtt.min.Text = Min;
			FRtt.sec.Text = Sec;
		}		
	}
	else
	{
		FRtt.sec.Text = Sec;
	}
}

function FRremove()
{
	FRtt.tname = null;
	FRtt.min = null;
	FRtt.col = null;
	FRtt.sec = null;
	FRtt.target = null;
	FRtt.name = null;
}







 
//========================================= C L A N  B A T T L E  R O U N D  S Y S T E M ================================================
 
function JoinArray( array, seperator )
{
  return array.reduce( function( prevData, nextData ){ return ( prevData + seperator + nextData ); } );
}
RoundLogo <- null; 
ClanName <- null;
ClanName2 <- null;
ClanScore1 <- 0;
ClanScore2 <- 0;
Round <- 0;
ClanPlayers1 <- null;
ClanPlayers2 <- null;
Subs1 <- null;
Subs2 <- null;
 
CBScoreboardDisplay <- {
    RoundGUI = { ClanBadge1 = null, ClanBadge2 = null, ClanLogo1 = null, ClanLogo2 = null, ClanName1 = null, ClanName2 = null, ClanScore1 = null, ClanScore2 = null },
    ScoreboardGUI = {
        Clan1Name = null,
        ClanPlrs1 = null,
        ClanSubs1 = null,
    //============================
        Clan2Name = null,
        ClanPlrs2 = null,
        ClanSubs2 = null,
    },
    VSLogo = null,
    Round = null,
}
 
function CBRoundScreen( strread )
{
	RoundLogo = GUISprite("wallpaper.png", VectorScreen(0,0));
    local params = split( strread, "," ), fclanlogo = params[0], sclanlogo = params[1];
    CBScoreboardDisplay.RoundGUI.ClanBadge1 = GUISprite( "empty badge.png", VectorScreen( ( screen.X * 0.05 ), ( screen.Y * 0.20 ) ) );
    CBScoreboardDisplay.RoundGUI.ClanBadge1.Size = VectorScreen( 360, 200 );
    if( fclanlogo == "true" )
    {  
        CBScoreboardDisplay.RoundGUI.ClanLogo1 = GUISprite( ""+ ClanName +".png", VectorScreen( ( screen.X * 0.05 ), ( screen.Y * 0.20 ) ) );
        CBScoreboardDisplay.RoundGUI.ClanLogo1.Size = VectorScreen( 320, 180 );
    }
    else
    {
        CBScoreboardDisplay.RoundGUI.ClanLogo1 = GUILabel( VectorScreen( ( screen.X * 0.07 ), ( screen.Y * 0.20 ) ), Colour( 0, 0, 0 ), "N/A" );
        CBScoreboardDisplay.RoundGUI.ClanLogo1.FontSize = 120;
        CBScoreboardDisplay.RoundGUI.ClanLogo1.FontName = "WRESTLEMANIA";
    }
    CBScoreboardDisplay.RoundGUI.ClanBadge2 = GUISprite( "empty badge.png", VectorScreen( ( screen.X * 0.57 ), ( screen.Y * 0.20 ) ) );
    CBScoreboardDisplay.RoundGUI.ClanBadge2.Size = VectorScreen( 360, 200 );
    if( sclanlogo == "true" )
    {  
        CBScoreboardDisplay.RoundGUI.ClanLogo2 = GUISprite( ""+ ::ClanName2 +".png", VectorScreen( ( screen.X * 0.62 ), ( screen.Y * 0.20 ) ) );
        CBScoreboardDisplay.RoundGUI.ClanLogo2.Size = VectorScreen( 320, 180 );

    }
    else
    {
        CBScoreboardDisplay.RoundGUI.ClanLogo2 = GUILabel( VectorScreen( ( screen.X * 0.58 ), ( screen.Y * 0.20 ) ), Colour( 0, 0, 0 ), "N/A" );
        CBScoreboardDisplay.RoundGUI.ClanLogo2.FontSize = 120;
        CBScoreboardDisplay.RoundGUI.ClanLogo2.FontName = "WRESTLEMANIA";
    }
    CBScoreboardDisplay.RoundGUI.ClanName1 = GUILabel( VectorScreen( ( screen.X * 0.03 ), ( screen.Y * 0.50 ) ), Colour( 100, 149, 237 ), ClanName );
    if( ClanName.len() < 20 ) CBScoreboardDisplay.RoundGUI.ClanName1.FontSize = 40;
    else CBScoreboardDisplay.RoundGUI.ClanName1.FontSize = 25;
    CBScoreboardDisplay.RoundGUI.ClanName1.FontName = "Copperplate Gothic Bold";
    CBScoreboardDisplay.RoundGUI.ClanName1.FontFlags = GUI_FFLAG_ULINE;
    CBScoreboardDisplay.RoundGUI.ClanName2 = GUILabel( VectorScreen( ( screen.X * 0.60 ), ( screen.Y * 0.50 ) ), Colour( 200, 0, 0 ), ::ClanName2 );
    if( ::ClanName2.len() < 20 ) CBScoreboardDisplay.RoundGUI.ClanName2.FontSize = 40;
    else CBScoreboardDisplay.RoundGUI.ClanName2.FontSize = 25;
    CBScoreboardDisplay.RoundGUI.ClanName2.FontName = "Copperplate Gothic Bold";
    CBScoreboardDisplay.RoundGUI.ClanName2.FontFlags = GUI_FFLAG_ULINE;
    CBScoreboardDisplay.VSLogo = GUILabel( VectorScreen( ( screen.X * 0.35 ), ( screen.Y * 0.25 ) ), Colour( 229, 137, 62 ), "VS" );
    CBScoreboardDisplay.VSLogo.FontSize = 120;
    CBScoreboardDisplay.VSLogo.FontName = "WRESTLEMANIA";
    CBScoreboardDisplay.Round = GUILabel( VectorScreen( ( screen.X * 0.20 ), ( screen.Y * 0.0050 ) ), Colour( 170, 165, 165 ), "Round "+Round+"" );
    CBScoreboardDisplay.Round.FontSize = 120;
    CBScoreboardDisplay.Round.FontName = "WRESTLEMANIA";
    CBScoreboardDisplay.RoundGUI.ClanScore1 = GUILabel( VectorScreen( ( screen.X * 0.33 ), ( screen.Y * 0.55 ) ), Colour( 229, 137, 62 ), ::ClanScore1 + ":" );
    CBScoreboardDisplay.RoundGUI.ClanScore1.FontSize = 110;
    CBScoreboardDisplay.RoundGUI.ClanScore1.FontName = "Copperplate Gothic Bold";
    CBScoreboardDisplay.RoundGUI.ClanScore2 = GUILabel( VectorScreen( ( screen.X * 0.44 ), ( screen.Y * 0.55 ) ), Colour( 229, 137, 62 ), ::ClanScore2 );
    CBScoreboardDisplay.RoundGUI.ClanScore2.FontSize = 110;
    CBScoreboardDisplay.RoundGUI.ClanScore2.FontName = "Copperplate Gothic Bold";
}
 
function CBRoundScoreboard()
{
    CBScoreboardDisplay.ScoreboardGUI.Clan1Name = GUILabel( VectorScreen( ( screen.X * 0.80 ), ( screen.Y * 0.40 ) ), Colour( 255, 255, 255 ), ClanName );
    CBScoreboardDisplay.ScoreboardGUI.Clan1Name.FontSize = 12;
    CBScoreboardDisplay.ScoreboardGUI.Clan1Name.FontFlags = GUI_FFLAG_BOLD;
    CBScoreboardDisplay.ScoreboardGUI.ClanPlrs1 = GUILabel( VectorScreen( ( screen.X * 0.80 ), ( screen.Y * 0.43 ) ), Colour( 255, 255, 255 ), ClanPlayers1 );
    CBScoreboardDisplay.ScoreboardGUI.ClanPlrs1.FontSize = 11;
    CBScoreboardDisplay.ScoreboardGUI.ClanSubs1 = GUILabel( VectorScreen( ( screen.X * 0.80 ), ( screen.Y * 0.45 ) ), Colour( 255, 255, 255 ), Subs1 );
    CBScoreboardDisplay.ScoreboardGUI.ClanSubs1.FontSize = 11;
    CBScoreboardDisplay.ScoreboardGUI.Clan2Name = GUILabel( VectorScreen( ( screen.X * 0.80 ), ( screen.Y * 0.47 ) ), Colour( 255, 255, 255 ), ::ClanName2 );
    CBScoreboardDisplay.ScoreboardGUI.Clan2Name.FontSize = 12;
    CBScoreboardDisplay.ScoreboardGUI.Clan2Name.FontFlags = GUI_FFLAG_BOLD;
    CBScoreboardDisplay.ScoreboardGUI.ClanPlrs2 = GUILabel( VectorScreen( ( screen.X * 0.80 ), ( screen.Y * 0.43 ) ), Colour( 255, 255, 255 ), ClanPlayers2 );
    CBScoreboardDisplay.ScoreboardGUI.ClanPlrs2.FontSize = 11;
    CBScoreboardDisplay.ScoreboardGUI.ClanSubs2 = GUILabel( VectorScreen( ( screen.X * 0.80 ), ( screen.Y * 0.45 ) ), Colour( 255, 255, 255 ), Subs2 );
    CBScoreboardDisplay.ScoreboardGUI.ClanSubs2.FontSize = 11;
}
 
function RemoveCBScoreboardDisplay()
{
    if( CBScoreboardDisplay.RoundGUI.ClanBadge1 != null || CBScoreboardDisplay.RoundGUI.ClanBadge2 != null )
    {
        CBScoreboardDisplay.RoundGUI.ClanBadge1 = null;
        CBScoreboardDisplay.RoundGUI.ClanBadge2 = null;
        CBScoreboardDisplay.RoundGUI.ClanLogo1 = null;
        CBScoreboardDisplay.RoundGUI.ClanLogo2 = null;
        CBScoreboardDisplay.RoundGUI.ClanName1 = null;
        CBScoreboardDisplay.RoundGUI.ClanName2 = null;
        CBScoreboardDisplay.RoundGUI.ClanScore1 = null;
        CBScoreboardDisplay.RoundGUI.ClanScore2 = null;
        CBScoreboardDisplay.VSLogo = null;
        CBScoreboardDisplay.Round = null;
    }
    else if( CBScoreboardDisplay.ScoreboardGUI.Clan1Name != null || CBScoreboardDisplay.ScoreboardGUI.Clan2Name != null )
    {
        CBScoreboardDisplay.ScoreboardGUI.Clan1Name = null;
        CBScoreboardDisplay.ScoreboardGUI.ClanPlrs1 = null;
        CBScoreboardDisplay.ScoreboardGUI.ClanSubs1 = null;
        CBScoreboardDisplay.ScoreboardGUI.Clan2Name = null;
        CBScoreboardDisplay.ScoreboardGUI.ClanPlrs2 = null;
        CBScoreboardDisplay.ScoreboardGUI.ClanSubs2 = null;
    }
}





























function SendDataToServer(str, int)
{
 local message = Stream();
 message.WriteInt(int.tointeger());
 message.WriteString(str);
 Server.SendData(message);
}






