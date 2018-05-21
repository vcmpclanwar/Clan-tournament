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

function GGupdate(strread)
{
	local sX = GUI.GetScreenSize().X, sY = GUI.GetScreenSize().Y;
//	local params = split(strread, " "), player = params[0], scr = params[i];
	if(GGscore.plr == "null : 0")
	{
		SendDataToServer("hi", 1);
	}
}
	

function SendDataToServer(str, int)
{
 local message = Stream();
 message.WriteInt(int.tointeger());
 message.WriteString(str);
 Server.SendData(message);
}




