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
	}
}




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

function GGstart(strread)
{
	local sX = GUI.GetScreenSize().X, sY = GUI.GetScreenSize().Y;
	Scoreboard.Label = GUILabel(VectorScreen((sX/2 + 150), (sY/2 - 100)), Colour(235, 0, 0), "Scoreboard : " + strread);
	Scoreboard.Label.FontSize = 12;
	Scoreboard.Label.FontFlags = GUI_FFLAG_BOLD;

	GGscore.plr = GUILabel(VectorScreen((sX/2 + 147), (sY/2 - 80)), Colour(255, 255, 255), "null : 0");
	GGscore.plr.FontSize = 11;

	GGscore.plr2 = GUILabel(VectorScreen((sX/2 + 147), (sY/2 - 67)), Colour(255, 255, 255), "null : 0");
	GGscore.plr2.FontSize = 11;

	GGscore.plr3 = GUILabel(VectorScreen((sX/2 + 147), (sY/2 - 54)), Colour(255, 255, 255), "null : 0");
	GGscore.plr3.FontSize = 11;

	GGscore.plr4 = GUILabel(VectorScreen((sX/2 + 147), (sY/2 - 41)), Colour(255, 255, 255), "null : 0");
	GGscore.plr4.FontSize = 11;

	GGscore.plr5 = GUILabel(VectorScreen((sX/2 + 147), (sY/2 - 28)), Colour(255, 255, 255), "null : 0");
	GGscore.plr5.FontSize = 11;


}

function GGupdate(string)
{
	local sX = GUI.GetScreenSize().X, sY = GUI.GetScreenSize().Y;
	local params = split(string, " "), player = params[0], scr = params[1];
	if(GGscore.plr.Text == "null : 0")
	{
		GGscore.plr.Text = player + " : "+scr;
	}
	else if(GGscore.plr2.Text == "null : 0")
	{
		GGscore.plr2.Text = player + " : "+scr;
	}
	else if(GGscore.plr3.Text == "null : 0")
	{
		GGscore.plr3.Text = player + " : "+scr;
	}
	else if(GGscore.plr4.Text == "null : 0")
	{
		GGscore.plr4.Text = player + " : "+scr;
	}
	else if(GGscore.plr5.Text == "null : 0")
	{
		GGscore.plr5.Text = player + " : "+scr;
	}
	else
	{
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
	SendDataToServer("hi", 1);
}
	

function SendDataToServer(str, int)
{
 local message = Stream();
 message.WriteInt(int.tointeger());
 message.WriteString(str);
 Server.SendData(message);
}




