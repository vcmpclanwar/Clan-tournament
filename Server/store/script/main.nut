_Return <- KeyBind( 0x0D );
DefaultSprite <- null;
function errorHandling(err)
{
    local stackInfos = getstackinfos(2);
    if (stackInfos)
    {
        local locals = "";
        foreach(index, value in stackInfos.locals)
        {
            if (index != "this")
                locals = locals + "[" + index + "] " + value + "\n";
        }
        local callStacks = "";
        local level = 2;
        do {
            callStacks += "*FUNCTION [" + stackInfos.func + "()] " + stackInfos.src + " line [" + stackInfos.line + "]\n";
            level++;
        } while ((stackInfos = getstackinfos(level)));
 
        local errorMsg = "AN ERROR HAS OCCURRED [" + err + "]\n";
        errorMsg += "\nCALLSTACK\n";
        errorMsg += callStacks;
        errorMsg += "\nLOCALS\n";
    }
    errorMsg += locals;
    Console.Print(errorMsg);
}
 
function Script::ScriptLoad()
{
//	seterrorhandler(errorHandling);
	WelcomeScreen.Create();
}


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
            WelcomeScreen.Setup(StreamReadString);
			Console.Print("data received");
        break;
		case 11:
			WelcomeScreen.ErrorText.Text = "Wrong Password";
		break;
		case 12:
			WelcomeScreen.ClearForm();
		break;
		default: break;

    }
}

WelcomeScreen <-
{
	player			= null
	Registered		= null
	LoggedIn		= null
	pass			= null
    Username		= null
    Outline			= null
    Password		= null
    PasswordText	= null
	ErrorText		= null
    Continue		= null
	ContinueSprite	= null
	InWork			= false
	
    Stage			= null
	Default			= null
    Wallpaper		= null
    Spinner			= null
    Information		= null

	timer			= null
	timer2			= null
	timer3			= null
	
	
	WallAlpha		= 500
	SpinnerAlpha	= 250
	
	InfoR			= 255
	InfoG			= 255
	InfoB			= 255
	InfoLoc			= 0.60
	


	function Setup(string)
	{
		local params = split(string, " ");
		this.player				<- params[0];
		this.Registered 		<- params[1].tointeger();
		this.LoggedIn 			<- params[2].tointeger();
		this.pass				<- params[3];
		this.InWork				<- true;
        this.Stage <- 1;

		Console.Print("data put");
	
	}
    function Create()
    {
	
	
		Hud.RemoveFlags(HUD_FLAG_CASH | HUD_FLAG_CLOCK | HUD_FLAG_HEALTH | HUD_FLAG_WEAPON | HUD_FLAG_WANTED | HUD_FLAG_RADAR);

		this.Default		 <- :: GUISprite("processor/wallpaper.png", VectorScreen(0,0), Colour(255,255,255,255));
		this.Default.Size = VectorScreen(screen.X, screen.Y);
		
		this.Wallpaper       <- ::GUISprite("wallpaper.png", VectorScreen(0, 0), Colour(255, 255, 255, 255));
		this.Wallpaper.Size = VectorScreen(screen.X, screen.Y);
		timer <-	Timer.Create(this, SetWallAlpha, 30, 100);
    }
	

    function Destroy()
    {
        this.Stage          <- null;
        this.Wallpaper      <- null;
        this.Spinner        <- null;
        this.Information    <- null;
		this.timer 			<- null;
		this.timer2			<- null;
		this.timer3			<- null;
		Timer.Delete(this.timer);
		Timer.Delete(this.timer2);
		Timer.Delete(this.timer3);
		GUI.SetMouseEnabled(false);  
		this.Username		<- null;
		this.Outline		<- null;
		this.Password		<- null;
		this.PasswordText	<- null;
		this.ErrorText		<- null;
		this.Continue		<- null;
		this.ContinueSprite	<- null;
		this.WallAlpha <- 255
		this.timer <- Timer.Create(this, CloseScreen, 30, 0);
	}
	
    function ClearForm()
    {
		Timer.Delete(this.timer);
		Timer.Delete(this.timer2);
		Timer.Delete(this.timer3);
		this.timer 			<- null;
		this.timer2			<- null;
		this.timer3			<- null;
		GUI.SetMouseEnabled(false);
		this.Username		<- null;
		this.Outline		<- null;
		this.Password		<- null;
		this.PasswordText	<- null;
		this.ErrorText		<- null;
		this.Continue		<- null;
		this.ContinueSprite	<- null;
		
		SetSpinner();
		SetInformation();
	}
	
	function SetWallAlpha()
	{
		if(this.WallAlpha > 255) this.WallAlpha = this.WallAlpha - 5;
		else
		{
			this.WallAlpha = this.WallAlpha - 5;
			this.Wallpaper.Colour = Colour(255, 255, 255, this.WallAlpha);
			if(this.WallAlpha == 0)
			{
				Timer.Delete(this.timer);
				this.timer	<-	null;
				this.Wallpaper <- null;
				CheckRegisteration();
			}
		}
	}
	function CloseScreen()
	{
		this.WallAlpha <- this.WallAlpha - 5;
		if(this.WallAlpha < 0) this.WallAlpha <- 0
		this.Default.Colour = Colour(255, 255, 255, this.WallAlpha);
		if(this.WallAlpha.tointeger() < 1)
		{
			Timer.Delete(this.timer);
			this.timer	<-	null;
			this.Default <- null;
			SendDataToServer("", 4);
			InWork <- "sidebar";
			this.Outline		<- ::GUISprite("processor/overlay.png", VectorScreen(screen.X * 0.72, screen.Y * 0.75), Colour(255, 255, 255, 150));
			this.Outline.Size = VectorScreen(screen.X * 0.25, screen.Y * 0.12);
			this.Information	<- ::GUILabel(VectorScreen(screen.X * 0.79, screen.Y * 0.76), Colour(255, 255, 255), "Vice City");
			this.Information.FontName = "WRESTLEMANIA";
			this.Information.FontSize = screen.X * 0.015;
			this.Default	<- ::GUILabel(VectorScreen(screen.X * 0.79, screen.Y * 0.79), Colour(255, 255, 255), "Clansmanship");
			this.Default.FontName = "WRESTLEMANIA";
			this.Default.FontSize = screen.X * 0.015;
			this.Continue	<- ::GUILabel(VectorScreen(screen.X * 0.79, screen.Y * 0.82), Colour(255, 255, 255), "League");
			this.Continue.FontName = "WRESTLEMANIA";
			this.Continue.FontSize = screen.X * 0.015;

			Hud.AddFlags(HUD_FLAG_CASH | HUD_FLAG_CLOCK | HUD_FLAG_HEALTH | HUD_FLAG_WEAPON | HUD_FLAG_WANTED | HUD_FLAG_RADAR);
		}
	}
	
	function CheckRegisteration()
	{
		if(this.Registered == 1) CheckLogin();
		else
		{

			GUI.SetMouseEnabled(true);

			this.Information	<- ::GUILabel(VectorScreen(screen.X * 0.28, screen.Y * 0.10), Colour(28, 174, 190), "Registeration");
			this.Information.FontFlags = GUI_FFLAG_BOLD;
			this.Information.TextAlignment = GUI_ALIGN_CENTERH;
			this.Information.FontName = "Candara";
			this.Information.FontSize = screen.X * 0.06;

			this.Username		<- ::GUILabel(VectorScreen(screen.X * 0.35, screen.Y * 0.29), Colour(28, 174, 190), this.player);
			this.Username.FontFlags = GUI_FFLAG_NONE;
			this.Username.TextAlignment = GUI_ALIGN_CENTERH;
			this.Username.FontName = "Corbel";
			this.Username.FontSize = screen.X * 0.04;

			this.PasswordText		<- ::GUILabel(VectorScreen(screen.X * 0.20, screen.Y * 0.42), Colour(0, 0, 0), "Password:");
			this.PasswordText.FontFlags = GUI_FFLAG_NONE;
			this.PasswordText.TextAlignment = GUI_ALIGN_CENTERH;
			this.PasswordText.FontName = "Corbel";
			this.PasswordText.FontSize = screen.X * 0.03;
        
			this.Password		<- ::GUIEditbox(VectorScreen(screen.X * 0.35, screen.Y * 0.42), VectorScreen(screen.X * 0.25, screen.Y * 0.07), Colour(255, 255, 255, 200));
			this.Password.AddFlags(GUI_FLAG_EDITBOX_MASKINPUT);
			this.Password.RemoveFlags(GUI_FLAG_BORDER);
			this.Password.FontName = "Corbel";
			this.Password.FontSize = screen.X * 0.03;

			this.ErrorText		<- ::GUILabel(VectorScreen(screen.X * 0.32, screen.Y * 0.5), Colour(200, 0, 0), "");
			this.ErrorText.FontFlags = GUI_FFLAG_NONE;
			this.ErrorText.TextAlignment = GUI_ALIGN_CENTERH;
			this.ErrorText.FontName = "Corbel";
			this.ErrorText.FontSize = screen.X * 0.02;

			
			this.Outline		<- ::GUISprite("Login/outline.png", VectorScreen(screen.X * 0.35, screen.Y * 0.42), Colour(255, 255, 255, 255));
			this.Outline.Size = VectorScreen(screen.X * 0.25, screen.Y * 0.07);
			
			this.ContinueSprite	<- ::GUISprite("Login/next.png", VectorScreen(screen.X * 0.60, screen.Y * 0.42), Colour(255, 255, 255, 255));
			this.ContinueSprite.Size = VectorScreen(screen.X * 0.05, screen.Y * 0.07);
			this.Continue		<- ::GUIButton(VectorScreen(screen.X * 0.60, screen.Y * 0.42), VectorScreen(screen.X * 0.05, screen.Y * 0.07), Colour(255, 255, 255, 0));
			GUI.SetFocusedElement(WelcomeScreen.Continue);
			
		}
	}
	function CheckLogin()
	{
		if(this.LoggedIn == 1)
		{
			SetInformation();
			SetSpinner();
		}
		else
		{
			GUI.SetMouseEnabled(true);

			this.Information	<- ::GUILabel(VectorScreen(screen.X * 0.38, screen.Y * 0.10), Colour(28, 174, 190), "Login");
			this.Information.FontFlags = GUI_FFLAG_BOLD;
			this.Information.TextAlignment = GUI_ALIGN_CENTERH;
			this.Information.FontName = "Candara";
			this.Information.FontSize = screen.X * 0.06;

			this.Username		<- ::GUILabel(VectorScreen(screen.X * 0.35, screen.Y * 0.29), Colour(28, 174, 190), this.player);
			this.Username.FontFlags = GUI_FFLAG_NONE;
			this.Username.TextAlignment = GUI_ALIGN_CENTERH;
			this.Username.FontName = "Corbel";
			this.Username.FontSize = screen.X * 0.04;

			this.PasswordText		<- ::GUILabel(VectorScreen(screen.X * 0.20, screen.Y * 0.42), Colour(0, 0, 0), "Password:");
			this.PasswordText.FontFlags = GUI_FFLAG_NONE;
			this.PasswordText.TextAlignment = GUI_ALIGN_CENTERH;
			this.PasswordText.FontName = "Corbel";
			this.PasswordText.FontSize = screen.X * 0.03;
        
			this.Password		<- ::GUIEditbox(VectorScreen(screen.X * 0.35, screen.Y * 0.42), VectorScreen(screen.X * 0.25, screen.Y * 0.07), Colour(255, 255, 255, 200));
			this.Password.AddFlags(GUI_FLAG_EDITBOX_MASKINPUT);
			this.Password.RemoveFlags(GUI_FLAG_BORDER);
			this.Password.FontName = "Corbel";
			this.Password.FontSize = screen.X * 0.03;

			this.ErrorText		<- ::GUILabel(VectorScreen(screen.X * 0.32, screen.Y * 0.5), Colour(200, 0, 0), "");
			this.ErrorText.FontFlags = GUI_FFLAG_NONE;
			this.ErrorText.TextAlignment = GUI_ALIGN_CENTERH;
			this.ErrorText.FontName = "Corbel";
			this.ErrorText.FontSize = screen.X * 0.02;

			
			this.Outline		<- ::GUISprite("Login/outline.png", VectorScreen(screen.X * 0.35, screen.Y * 0.42), Colour(255, 255, 255, 255));
			this.Outline.Size = VectorScreen(screen.X * 0.25, screen.Y * 0.07);
			
			this.ContinueSprite	<- ::GUISprite("Login/next.png", VectorScreen(screen.X * 0.60, screen.Y * 0.42), Colour(255, 255, 255, 255));
			this.ContinueSprite.Size = VectorScreen(screen.X * 0.05, screen.Y * 0.07);
			this.Continue		<- ::GUIButton(VectorScreen(screen.X * 0.60, screen.Y * 0.42), VectorScreen(screen.X * 0.05, screen.Y * 0.07), Colour(255, 255, 255, 0));
			GUI.SetFocusedElement(WelcomeScreen.Continue);
		
		}
	}
	
	function SetSpinner()
	{
		this.Spinner         <- ::GUISprite("processor/spinner/20.png", VectorScreen(screen.X * 0.21, screen.Y * 0.36), Colour(255, 255, 255, 255));
		this.Spinner.Size = VectorScreen(screen.X * 0.20, screen.Y * 0.20);
		timer <- 	Timer.Create(this, ChangeSpinner, 35, 0);
	}
	function ChangeSpinner()
	{
		this.Spinner.SetTexture("processor/spinner/" + this.Stage + ".png");
		this.Stage <- this.Stage + 1;
		if (this.Stage > 90)
		{
			this.Stage <- 1;
		}
	}
	function ChangeSpinnerAlpha()
	{
		this.SpinnerAlpha = this.SpinnerAlpha - 5;
		if(this.SpinnerAlpha < 1)
		{
			Timer.Delete(this.timer3);
			this.timer3 <- null;
		}
		else this.Spinner.Colour = Colour(255,255,255,this.SpinnerAlpha);
	}
	function SetInformation()
	{
		this.Information    <- ::GUILabel(VectorScreen(screen.X * 0.38, screen.Y * 0.4), Colour(255, 255, 255), "Welcome");
		this.Information.FontName = "Candara";
		this.Information.FontSize = screen.X * 0.05;
		timer2 	<- Timer.Create(this, ChangeInfoColour, 35, 0);
	}
	function ChangeInfoColour()
	{
		this.InfoR <- this.InfoR - 5;
		this.InfoG <- this.InfoG - 5;
		this.InfoB <- this.InfoB - 5;
		if(this.InfoR < 28) this.InfoR <- 28;
		if(this.InfoG < 194) this.InfoG <- 194;
		if(this.InfoB < 170) this.InfoB <- 170;

		if(this.InfoR.tointeger() == 28 && this.InfoG.tointeger() == 194 && this.InfoB.tointeger() == 170)
		{
			Timer.Delete(this.timer2);
			timer2 	<- Timer.Create(this, ChangeInfoAlpha, 35, 0);
		}
		else
		{
			this.Information    <- ::GUILabel(VectorScreen(screen.X * 0.38, screen.Y * 0.4), Colour(this.InfoR, this.InfoG, this.InfoG), "Welcome");
			this.Information.FontName = "Candara";
			this.Information.FontSize = screen.X * 0.05;
		}

	}
	function ChangeInfoAlpha()
	{
		
		this.InfoR <- this.InfoR + 5;
		this.InfoG <- this.InfoG + 5;
		this.InfoB <- this.InfoB + 5;
		if(this.InfoR > 255) this.InfoR <- 255;
		if(this.InfoG > 255) this.InfoG <- 255;
		if(this.InfoB > 255) this.InfoB <- 255;

		if(this.InfoR == 255 && this.InfoG == 255 && this.InfoB == 255)
		{
			Timer.Delete(this.timer);
			Timer.Delete(this.timer2);
			Timer.Delete(this.timer3);
			Destroy();
		}
		else
		{
			this.Information    <- ::GUILabel(VectorScreen(screen.X * 0.38, screen.Y * 0.4), Colour(this.InfoR, this.InfoG, this.InfoG), "Welcome");
			this.Information.FontName = "Candara";
			this.Information.FontSize = screen.X * 0.05;
		}
		if(this.InfoR < 230)
		{
			timer3 <- 	Timer.Create(this, ChangeSpinnerAlpha, 400, 0);
		}

	}
}

 
 
function GUI::ElementClick(element, mouseX, mouseY)
{
	if(element == WelcomeScreen.Continue)
	{
		if(WelcomeScreen.Registered == 0)
		{
			if(WelcomeScreen.Password.Text.len() < 4) WelcomeScreen.ErrorText.Text = "Password should contain atleast 4 characters.";
			else
			{
				SendDataToServer(WelcomeScreen.Password.Text, 2);
				WelcomeScreen.ClearForm();
			}
		}
		else
		{
			if(WelcomeScreen.Password.Text.len() < 4) WelcomeScreen.ErrorText.Text = "Wrong Password";
			else
			{
				SendDataToServer(WelcomeScreen.Password.Text, 3);
			}
			
		}
	}

} 
 
function KeyBind::OnDown( key )
{
	if ( key == _Return && WelcomeScreen.InWork == true )
	{
		if(WelcomeScreen.Registered == 0)
		{
			if(WelcomeScreen.Password.Text.len() < 4) WelcomeScreen.ErrorText.Text = "Password should contain atleast 4 characters.";
			else
			{
				SendDataToServer(WelcomeScreen.Password.Text, 2);
				WelcomeScreen.ClearForm();
			}
		}
		else
		{
			if(WelcomeScreen.Password.Text.len() < 4) WelcomeScreen.ErrorText.Text = "Wrong Password";
			else
			{
				SendDataToServer(WelcomeScreen.Password.Text, 3);
			}
			
		}
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

 function Delete(hash)
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
	Scoreboard.Label = GUILabel(VectorScreen((screen.X * 0.75), (screen.Y * 0.40)), Colour(235, 0, 0), "Scoreboard : " + strread);
	Scoreboard.Label.FontSize = screen.X * 0.015;
	Scoreboard.Label.FontFlags = GUI_FFLAG_BOLD;

	GGscore.plr = GUILabel(VectorScreen((screen.X * 0.75), (screen.Y * 0.43)), Colour(255, 255, 255), "null : 0");
	GGscore.plr.FontSize = screen.X * 0.015;

	GGscore.plr2 = GUILabel(VectorScreen((screen.X * 0.75), (screen.Y * 0.46)), Colour(255, 255, 255), "null : 0");
	GGscore.plr2.FontSize = screen.X * 0.015;

	GGscore.plr3 = GUILabel(VectorScreen((screen.X * 0.75), (screen.Y * 0.49)), Colour(255, 255, 255), "null : 0");
	GGscore.plr3.FontSize = screen.X * 0.015;

	GGscore.plr4 = GUILabel(VectorScreen((screen.X * 0.75), (screen.Y * 0.52)), Colour(255, 255, 255), "null : 0");
	GGscore.plr4.FontSize = screen.X * 0.015;

	GGscore.plr5 = GUILabel(VectorScreen((screen.X * 0.75), (screen.Y * 0.55)), Colour(255, 255, 255), "null : 0");
	GGscore.plr5.FontSize = screen.X * 0.015;


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
	FRtt.target.FontSize = screen.X * 0.015;
	FRtt.target.FontFlags = GUI_FFLAG_BOLD;
	FRtt.name = GUILabel(VectorScreen((screen.X * 0.86), (screen.Y * 0.85)), Colour(255, 255, 255), strread);
	FRtt.name.FontSize = screen.X * 0.015;
	FRtt.name.FontFlags = GUI_FFLAG_BOLD;
	
	FRtt.tname = GUILabel(VectorScreen((screen.X * 0.80), (screen.Y * 0.88)), Colour(235, 0, 0), "Time Left:");
	FRtt.tname.FontFlags = GUI_FFLAG_BOLD;
	FRtt.tname.FontSize = screen.X * 0.015;
	
	FRtt.min = GUILabel(VectorScreen((screen.X * 0.865), (screen.Y * 0.883)), Colour(255, 255, 255), "02");
	FRtt.col = GUILabel(VectorScreen((screen.X * 0.875), (screen.Y * 0.883)), Colour(255, 255, 255), ":");
	FRtt.sec = GUILabel(VectorScreen((screen.X * 0.885), (screen.Y * 0.883)), Colour(255, 255, 255), "00");
	FRtt.min.FontSize = screen.X * 0.015;
	FRtt.col.FontSize = screen.X * 0.013;
	FRtt.sec.FontSize = screen.X * 0.013;
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
			Timer.Delete(FRtimetimer);
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











function GUI::GameResize(width, height) 
{
screen <- GUI.GetScreenSize();
	if(WelcomeScreen.InWork == true)
	{
		if(this.Default != null) this.Default.Size = VectorScreen(screen.X, screen.Y);
		if(this.Wallpaper != null) this.Wallpaper.Size = VectorScreen(screen.X, screen.Y);
		if(this.Registeration == 0)
		{
			this.Information.Position = VectorScreen(screen.X * 0.28, screen.Y * 0.10);
			this.Information.FontSize = screen.X * 0.06;

			this.Username.Position = VectorScreen(screen.X * 0.35, screen.Y * 0.29);
			this.Username.FontSize = screen.X * 0.04;

			this.PasswordText.Position = VectorScreen(screen.X * 0.20, screen.Y * 0.42);
			this.PasswordText.FontSize = screen.X * 0.03;

			this.Password.Position = VectorScreen(screen.X * 0.35, screen.Y * 0.42);
			this.Password.FontSize = screen.X * 0.03;

			this.ErrorText.Position = VectorScreen(screen.X * 0.32, screen.Y * 0.5);
			this.ErrorText.FontSize = screen.X * 0.02;

			this.Outline.Position = VectorScreen(screen.X * 0.35, screen.Y * 0.42);
			this.Outline.Size = VectorScreen(screen.X * 0.25, screen.Y * 0.07);

			this.ContinueSprite.Position = VectorScreen(screen.X * 0.60, screen.Y * 0.42);
			this.ContinueSprite.Size = VectorScreen(screen.X * 0.05, screen.Y * 0.07);

			this.Continue.Position =VectorScreen(screen.X * 0.60, screen.Y * 0.42);
			this.Continue.Size = VectorScreen(screen.X * 0.05, screen.Y * 0.07);
			}
		}
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


























