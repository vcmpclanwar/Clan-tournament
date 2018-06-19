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
			
		break;
		case 9:
			
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


function SendDataToServer(str, int)
{
 local message = Stream();
 message.WriteInt(int.tointeger());
 message.WriteString(str);
 Server.SendData(message);
}




