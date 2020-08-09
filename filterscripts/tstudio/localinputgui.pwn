#include "localinputguidata.pwn"

#include <YSI_Coding\y_hooks>

#define CLICK_EXIT_MENU              (1005)

#define CLICK_TOOL_MAPMENU           (1000)
#define CLICK_TOOL_OBJMENU           (1001)
#define CLICK_TOOL_GRPMENU           (1002)
#define CLICK_TOOL_TEXSEARCH         (1003)
#define CLICK_TOOL_MODSEARCH         (1004)

#define CLICK_MAP_NEWMAP             (2000)
#define CLICK_MAP_LOADMAP            (2001)
#define CLICK_MAP_RENAMEMAP          (2002)
#define CLICK_MAP_IMPORTMAP          (2003)
#define CLICK_MAP_EXPORTMAP          (2004)

#define CLICK_OBJ_CLONE              (3000)
#define CLICK_OBJ_CREATE             (3001)
#define CLICK_OBJ_DELETE             (3002)
#define CLICK_OBJ_GROUP_INPUT        (3003)
#define CLICK_OBJ_GROUP_L            (3004)
#define CLICK_OBJ_GROUP_R            (3005)
#define CLICK_OBJ_MODEL_INPUT        (3006)
#define CLICK_OBJ_MODEL_L            (3007)
#define CLICK_OBJ_MODEL_R            (3008)
#define CLICK_OBJ_NOTE_INPUT         (3009)
#define CLICK_OBJ_TRANSFORM          (3010)

#define CLICK_OBJMOVE_BACK           (3100)
#define CLICK_OBJMOVE_MORE           (3101)
#define CLICK_OBJMOVE_X_INPUT        (3102)
#define CLICK_OBJMOVE_X_L            (3103)
#define CLICK_OBJMOVE_X_R            (3104)
#define CLICK_OBJMOVE_Y_INPUT        (3105)
#define CLICK_OBJMOVE_Y_L            (3106)
#define CLICK_OBJMOVE_Y_R            (3107)
#define CLICK_OBJMOVE_Z_INPUT        (3108)
#define CLICK_OBJMOVE_Z_L            (3109)
#define CLICK_OBJMOVE_Z_R            (3110)
#define CLICK_OBJMOVE_RX_INPUT       (3111)
#define CLICK_OBJMOVE_RX_L           (3112)
#define CLICK_OBJMOVE_RX_R           (3113)
#define CLICK_OBJMOVE_RY_INPUT       (3114)
#define CLICK_OBJMOVE_RY_L           (3115)
#define CLICK_OBJMOVE_RY_R           (3116)
#define CLICK_OBJMOVE_RZ_INPUT       (3117)
#define CLICK_OBJMOVE_RZ_L           (3118)
#define CLICK_OBJMOVE_RZ_R           (3119)
#define CLICK_OBJMOVE_RESROT         (3120)
#define CLICK_OBJMOVE_NUDPOS_INPUT   (3121)
#define CLICK_OBJMOVE_NUDPOS_L       (3122)
#define CLICK_OBJMOVE_NUDPOS_R       (3123)
#define CLICK_OBJMOVE_NUDROT_INPUT   (3124)
#define CLICK_OBJMOVE_NUDROT_L       (3125)
#define CLICK_OBJMOVE_NUDROT_R       (3126)

#define CLICK_OBJMOVEMORE_TOCURSOR   (3200)
#define CLICK_OBJMOVEMORE_TOFRONT    (3201)
#define CLICK_OBJMOVEMORE_TOGROUND   (3202)
#define CLICK_OBJMOVEMORE_TRANSFORM  (3203)

#define CLICK_GRP_CLEARSEL           (4000)
#define CLICK_GRP_SELALLOBJ          (4001)
#define CLICK_GRP_SELGRPID           (4002)
#define CLICK_GRP_ADDOBJID           (4003)
#define CLICK_GRP_ADDRANGE           (4004)
#define CLICK_GRP_ADDSELOBJ          (4005)
#define CLICK_GRP_REMOBJID           (4006)
#define CLICK_GRP_REMRANGE           (4007)
#define CLICK_GRP_REMSELOBJ          (4008)
#define CLICK_GRP_SETGRPID           (4009)
#define CLICK_GRP_TRANSFORM          (4010)

#define CLICK_GRPMOVE_BACK           (4100)
#define CLICK_GRPMOVE_MORE           (4101)
#define CLICK_GRPMOVE_X_L            (4102)
#define CLICK_GRPMOVE_X_R            (4103)
#define CLICK_GRPMOVE_Y_L            (4104)
#define CLICK_GRPMOVE_Y_R            (4105)
#define CLICK_GRPMOVE_Z_L            (4106)
#define CLICK_GRPMOVE_Z_R            (4107)
#define CLICK_GRPMOVE_RX_L           (4108)
#define CLICK_GRPMOVE_RX_R           (4109)
#define CLICK_GRPMOVE_RY_L           (4110)
#define CLICK_GRPMOVE_RY_R           (4111)
#define CLICK_GRPMOVE_RZ_L           (4112)
#define CLICK_GRPMOVE_RZ_R           (4113)
#define CLICK_GRPMOVE_NUDPOS_INPUT   (4114)
#define CLICK_GRPMOVE_NUDPOS_L       (4115)
#define CLICK_GRPMOVE_NUDPOS_R       (4116)
#define CLICK_GRPMOVE_NUDROT_INPUT   (4117)
#define CLICK_GRPMOVE_NUDROT_L       (4118)
#define CLICK_GRPMOVE_NUDROT_R       (4119)

#define CLICK_GRPMOVEMORE_TOCURSOR   (4200)
#define CLICK_GRPMOVEMORE_TOFRONT    (4201)
#define CLICK_GRPMOVEMORE_TOGROUND   (4202)
#define CLICK_GRPMOVEMORE_TRANSFORM  (4203)






// Main GUI
static GUIMenu:ToolBar;
static GUIMenu:MenuMap;
static GUIMenu:MenuObject;
static GUIMenu:MenuObjectMove;
static GUIMenu:MenuObjectMoveMore;
static GUIMenu:MenuGroup;
static GUIMenu:MenuGroupMove;
static GUIMenu:MenuGroupMoveMore;

//static PlayerGUIMenu:ToolBar[MAX_PLAYERS];
static PlayerGUIMenu:PlayerMenuMap[MAX_PLAYERS];
static PlayerGUIMenu:PlayerMenuObject[MAX_PLAYERS];
static PlayerGUIMenu:PlayerMenuObjectMove[MAX_PLAYERS];
static PlayerGUIMenu:PlayerMenuObjectMoveMore[MAX_PLAYERS];
static PlayerGUIMenu:PlayerMenuGroup[MAX_PLAYERS];
static PlayerGUIMenu:PlayerMenuGroupMove[MAX_PLAYERS];
static PlayerGUIMenu:PlayerMenuGroupMoveMore[MAX_PLAYERS];

// GUI Groups

//static PlayerGUIMenu:PlayerMenuAll[MAX_PLAYERS];
//static PlayerGUIMenu:PlayerMenuSubmenuAll[MAX_PLAYERS];

static PlayerGUIMenu:PlayerMenuMapAll[MAX_PLAYERS];
static PlayerGUIMenu:PlayerMenuObjectAll[MAX_PLAYERS];
static PlayerGUIMenu:PlayerMenuGroupAll[MAX_PLAYERS];

// Element data, for textdraws specific to a player
enum PLAYER_MENU_DATA {
	E_ObjModel,
	E_ObjGroup,
	E_ObjNote,
	E_ObjX,
	E_ObjY,
	E_ObjZ,
	E_ObjRX,
	E_ObjRY,
	E_ObjRZ,
	E_ObjNudPos,
	E_ObjNudRot,
	E_GrpNudPos,
	E_GrpNudRot
}
new PlayerElementData[MAX_PLAYERS][PLAYER_MENU_DATA];





hook OnScriptInit()
{
	new tmpArray[MAX_ELEMENTS][GUIDEF], tmpCount;
	
	// TOOL BAR

	ToolBar = CreateGUI("ToolBar");

	LoadGUIMenu(ToolBar, ToolBarBox, 0.0, 428.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(ToolBar, E_INDEX[0], 640.0, 20.0);

	LoadGUIMenu(ToolBar, ToolBarButton, 2.0, 430.0, CLICK_TOOL_MAPMENU, E_INDEX);
	GUISetTextSize(ToolBar, E_INDEX[0], 48.0, 16.0);
	GUISetPlayerText(ToolBar, E_INDEX[1], "Map_Menu");

	LoadGUIMenu(ToolBar, ToolBarButton, 52.0, 430.0, CLICK_TOOL_OBJMENU, E_INDEX);
	GUISetTextSize(ToolBar, E_INDEX[0], 58.0, 16.0);
	GUISetPlayerText(ToolBar, E_INDEX[1], "Object_Menu");

	LoadGUIMenu(ToolBar, ToolBarButton, 112.0, 430.0, CLICK_TOOL_GRPMENU, E_INDEX);
	GUISetTextSize(ToolBar, E_INDEX[0], 58.0, 16.0);
	GUISetPlayerText(ToolBar, E_INDEX[1], "Group_Menu");

	LoadGUIMenu(ToolBar, ToolBarInfo, 200.0, 430.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(ToolBar, E_INDEX[0], 240.0, 16.0);
	GUISetPlayerText(ToolBar, E_INDEX[1], "Texture_Studio_1.20");

	LoadGUIMenu(ToolBar, ToolBarButton, 484.0, 430.0, CLICK_TOOL_TEXSEARCH, E_INDEX);
	GUISetTextSize(ToolBar, E_INDEX[0], 67.0, 16.0);
	GUISetPlayerText(ToolBar, E_INDEX[1], "Texture_Search");

	LoadGUIMenu(ToolBar, ToolBarButton, 553.0, 430.0, CLICK_TOOL_MODSEARCH, E_INDEX);
	GUISetTextSize(ToolBar, E_INDEX[0], 61.0, 16.0);
	GUISetPlayerText(ToolBar, E_INDEX[1], "Model_Search");

	LoadGUIMenu(ToolBar, ToolBarButton, 616.0, 430.0, CLICK_EXIT_MENU, E_INDEX);
	GUISetTextSize(ToolBar, E_INDEX[0], 22.0, 16.0);
	GUISetPlayerText(ToolBar, E_INDEX[1], "Exit");

	// MAP MENU

	MenuMap = CreateGUI("MenuMap");

	LoadGUIMenu(MenuMap, MenuBox, 500.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuMap, E_INDEX[0], 120.0, 146.0); // back box

	LoadGUIMenu(MenuMap, MenuHeader, 500.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuMap, E_INDEX[0], 120.0, 16.0); // header box
	GUISetPlayerText(MenuMap, E_INDEX[1], "Map_Menu");

	/* THEORY */
	/*AdjustGUIMenuDataFloat(tmpArray, 0, GUITextSizeX, 37.0, GUITextSizeY, 16.0);*/
	/*AdjustGUIMenuData(tmpArray, 0, GUITextSizeX, 37.0);
	tmpArray = AdjustGUIMenuData(tmpArray, 0, GUITextSizeY, 16.0);*/
	/*AdjustGUIMenuDataText(tmpArray, 1, "New");*/
	//tmpArray[0][GUITextSizeX] = 37.0;
	//tmpArray[0][GUITextSizeY] = 16.0;
	//tmpArray[1][GUIText] = "New";
	/* THEORY */
	
	/*tmpCount = CopyGUIMenuData(MenuButton, tmpArray);
	tmpArray = AdjustGUIMenuData(tmpArray, 1, .setText = "X", .setAlignment = 2);
	LoadGUIMenu(MenuMap, tmpArray, 502.0, 146.0, CLICK_MAP_NEWMAP, E_INDEX, tmpCount);
	GUISetTextSize(MenuMap, E_INDEX[0], 37.0, 16.0);*/
	
	LoadGUIMenu(MenuMap, MenuButton, 502.0, 146.0, CLICK_MAP_NEWMAP, E_INDEX);
	GUISetTextSize(MenuMap, E_INDEX[0], 37.0, 16.0); // new map button
	GUISetPlayerText(MenuMap, E_INDEX[1], "New");
	
	LoadGUIMenu(MenuMap, MenuButton, 541.0, 146.0, CLICK_MAP_LOADMAP, E_INDEX);
	GUISetTextSize(MenuMap, E_INDEX[0], 37.0, 16.0); // load map button
	GUISetPlayerText(MenuMap, E_INDEX[1], "Load");

	LoadGUIMenu(MenuMap, MenuButton, 580.0, 146.0, CLICK_MAP_RENAMEMAP, E_INDEX);
	GUISetTextSize(MenuMap, E_INDEX[0], 38.0, 16.0); // rename map button
	GUISetPlayerText(MenuMap, E_INDEX[1], "Rename");

	LoadGUIMenu(MenuMap, MenuButton, 502.0, 164.0, CLICK_MAP_IMPORTMAP, E_INDEX);
	GUISetTextSize(MenuMap, E_INDEX[0], 57.0, 16.0); // import map button
	GUISetPlayerText(MenuMap, E_INDEX[1], "Import");

	LoadGUIMenu(MenuMap, MenuButton, 561.0, 164.0, CLICK_MAP_EXPORTMAP, E_INDEX);
	GUISetTextSize(MenuMap, E_INDEX[0], 57.0, 16.0); // export map button
	GUISetPlayerText(MenuMap, E_INDEX[1], "Export");

	LoadGUIMenu(MenuMap, MenuHeader, 500.0, 182.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuMap, E_INDEX[0], 120.0, 16.0); // prop header box
	GUISetPlayerText(MenuMap, E_INDEX[1], "Properties");

	LoadGUIMenu(MenuMap, MenuInfo, 502.0, 200.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuMap, E_INDEX[0], 116.0, 72.0); // prop info box
	GUISetPlayerText(MenuMap, E_INDEX[1], "Name~n~Object_Count:_100~n~Vehicle_Count:_20~n~Spawn:_X,_Y,_Z~n~Interior_1,_World_1");

	// OBJECT MENU

	MenuObject = CreateGUI("MenuObject");

	LoadGUIMenu(MenuObject, MenuBox, 500.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 120.0, 216.0); // back box

	LoadGUIMenu(MenuObject, MenuHeader, 500.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 120.0, 16.0); // header box
	GUISetPlayerText(MenuObject, E_INDEX[1], "Object_Menu");
	//
	LoadGUIMenu(MenuObject, MenuButton, 502.0, 146.0, CLICK_OBJ_CREATE, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 37.0, 16.0); // create button
	GUISetPlayerText(MenuObject, E_INDEX[1], "Create");

	LoadGUIMenu(MenuObject, MenuButton, 541.0, 146.0, CLICK_OBJ_DELETE, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 37.0, 16.0); // delete button
	GUISetPlayerText(MenuObject, E_INDEX[1], "Delete");

	LoadGUIMenu(MenuObject, MenuButton, 580.0, 146.0, CLICK_OBJ_CLONE, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 38.0, 16.0); // clone button
	GUISetPlayerText(MenuObject, E_INDEX[1], "Clone");
	//
	LoadGUIMenu(MenuObject, MenuText, 502.0, 164.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 31.0, 16.0); // model text
	GUISetPlayerText(MenuObject, E_INDEX[1], "Model");

	LoadGUIMenu(MenuObject, MenuSpriteButton, 602.0, 164.0, CLICK_OBJ_MODEL_R, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 16.0, 16.0); // model right button
	GUISetPlayerText(MenuObject, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuObject, MenuSpriteButton, 584.0, 164.0, CLICK_OBJ_MODEL_L, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 16.0, 16.0); // model left button
	GUISetPlayerText(MenuObject, E_INDEX[1], "LD_BEAT:left");
	
	//
	LoadGUIMenu(MenuObject, MenuText, 502.0, 182.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 31.0, 16.0); // group text
	GUISetPlayerText(MenuObject, E_INDEX[1], "Group");

	LoadGUIMenu(MenuObject, MenuSpriteButton, 602.0, 182.0, CLICK_OBJ_GROUP_R, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 16.0, 16.0); // group right button
	GUISetPlayerText(MenuObject, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuObject, MenuSpriteButton, 584.0, 182.0, CLICK_OBJ_GROUP_L, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 16.0, 16.0); // group left button
	GUISetPlayerText(MenuObject, E_INDEX[1], "LD_BEAT:left");
	
	//
	LoadGUIMenu(MenuObject, MenuText, 502.0, 200.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 27.0, 16.0); // note text
	GUISetPlayerText(MenuObject, E_INDEX[1], "Note");
	
	//
	LoadGUIMenu(MenuObject, MenuButton, 502.0, 218.0, CLICK_OBJ_TRANSFORM, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 116.0, 16.0); // transform button
	GUISetPlayerText(MenuObject, E_INDEX[1], "Transform_Menu");
	//
	LoadGUIMenu(MenuObject, MenuHeader, 500.0, 236.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 120.0, 16.0); // prop header box
	GUISetPlayerText(MenuObject, E_INDEX[1], "Properties");

	LoadGUIMenu(MenuObject, MenuInfo, 502.0, 254.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 116.0, 87.0); // prop info box
	GUISetPlayerText(MenuObject, E_INDEX[1], "Object_ID:_123~n~Pos:_X,_Y,_Z~n~Rot:_X,_Y,_Z~n~Model_Info:~n~-_Length:_10.00~n~-_Width:_10.00~n~-_Height:_10.00~n~Etcetera...");

	// OBJECT-MOVE MENU

	MenuObjectMove = CreateGUI("MenuObjectMove");

	LoadGUIMenu(MenuObjectMove, MenuBox, 500.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 120.0, 216.0); // back box

	LoadGUIMenu(MenuObjectMove, MenuHeader, 500.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 120.0, 16.0); // header box
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "Object_Movement");
	//
	LoadGUIMenu(MenuObjectMove, MenuHeaderMoreButton, 604.0, 128.0, CLICK_OBJMOVE_MORE, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // header more button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "...");

	LoadGUIMenu(MenuObjectMove, MenuHeaderButton, 579.0, 128.0, CLICK_OBJMOVE_BACK, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 25.0, 16.0); // header back button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "Back");
	//
	
	/*//TMP
	tmpCount = CopyGUIMenuData(MenuSpriteButton, tmpArray);
	tmpArray = AdjustGUIMenuData(tmpArray, 0, .setTextSizeX = 16.0, .setTextSizeY = 16.0);
	tmpArray = AdjustGUIMenuData(tmpArray, 1, .setText = "LD_BEAT:right", .setFont = 4);
	LoadGUIMenu(MenuObjectMove, tmpArray, 602.0, 146.0, CLICK_OBJMOVE_X_L, E_INDEX, tmpCount);
	//TMP*/
	
	tmpCount = CopyGUIMenuData(MenuText, tmpArray);
	tmpArray = AdjustGUIMenuData(tmpArray, 0, .setTextSizeX = 16.0, .setTextSizeY = 16.0);
	tmpArray = AdjustGUIMenuData(tmpArray, 1, .setOffX = 8.0, .setText = "X", .setAlignment = 2);
	
	LoadGUIMenu(MenuObjectMove, tmpArray, 502.0, 146.0, CLICK_NO_GROUP, E_INDEX, tmpCount);
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "X"); // X text

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 602.0, 146.0, CLICK_OBJMOVE_X_L, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // X left button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 584.0, 146.0, CLICK_OBJMOVE_X_R, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // X right button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:left");
	//
	LoadGUIMenu(MenuObjectMove, tmpArray, 502.0, 164.0, CLICK_NO_GROUP, E_INDEX, tmpCount);
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "Y"); // Y text

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 602.0, 164.0, CLICK_OBJMOVE_Y_L, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // Y left button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 584.0, 164.0, CLICK_OBJMOVE_Y_R, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // Y right button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:left");
	//
	LoadGUIMenu(MenuObjectMove, tmpArray, 502.0, 182.0, CLICK_NO_GROUP, E_INDEX, tmpCount);
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "Z"); // Z text

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 602.0, 182.0, CLICK_OBJMOVE_Z_L, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // Z left button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 584.0, 182.0, CLICK_OBJMOVE_Z_R, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // Z right button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:left");
	//
	LoadGUIMenu(MenuObjectMove, MenuHeader, 500.0, 200.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 120.0, 16.0); // rot header box
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "Rotation");
	//
	LoadGUIMenu(MenuObjectMove, tmpArray, 502.0, 218.0, CLICK_NO_GROUP, E_INDEX, tmpCount);
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "RX"); // RX text

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 602.0, 218.0, CLICK_OBJMOVE_RX_L, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // RX left button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 584.0, 218.0, CLICK_OBJMOVE_RX_R, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // RX right button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:left");
	//
	LoadGUIMenu(MenuObjectMove, tmpArray, 502.0, 236.0, CLICK_NO_GROUP, E_INDEX, tmpCount);
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "RY"); // RY text

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 602.0, 236.0, CLICK_OBJMOVE_RY_L, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // RY left button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 584.0, 236.0, CLICK_OBJMOVE_RY_R, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // RY right button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:left");
	//
	LoadGUIMenu(MenuObjectMove, tmpArray, 502.0, 254.0, CLICK_NO_GROUP, E_INDEX, tmpCount);
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "RZ"); // RZ text

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 602.0, 254.0, CLICK_OBJMOVE_RZ_L, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // RZ left button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 584.0, 254.0, CLICK_OBJMOVE_RZ_R, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // RZ right button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:left");

	LoadGUIMenu(MenuObjectMove, MenuButton, 502.0, 272.0, CLICK_OBJMOVE_RESROT, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 116.0, 16.0); // reset rot right button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "Reset_Rotation");
	//
	LoadGUIMenu(MenuObjectMove, MenuHeader, 500.0, 290.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 120.0, 16.0); // nudge header box
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "Nudge_Settings");
	//
	LoadGUIMenu(MenuObjectMove, MenuText, 502.0, 308.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 20.0, 16.0); // nudge pos text
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "Pos");

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 602.0, 308.0, CLICK_OBJMOVE_NUDPOS_R, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // nudge pos right button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 584.0, 308.0, CLICK_OBJMOVE_NUDPOS_L, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // nudge pos left button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:left");
	//
	LoadGUIMenu(MenuObjectMove, MenuText, 502.0, 326.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 20.0, 16.0); // nudge rot text
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "Rot");

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 602.0, 326.0, CLICK_OBJMOVE_NUDROT_R, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // nudge rot right button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 584.0, 326.0, CLICK_OBJMOVE_NUDROT_L, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // nudge rot left button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:left");

	// OBJECT-MOVE MORE MENU

	MenuObjectMoveMore = CreateGUI("MenuObjectMoveMore");

	LoadGUIMenu(MenuObjectMoveMore, MenuBox, 420.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObjectMoveMore, E_INDEX[0], 80.0, 90.0); // back box

	LoadGUIMenu(MenuObjectMoveMore, MenuHeader, 420.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObjectMoveMore, E_INDEX[0], 80.0, 16.0); // header box
	GUISetPlayerText(MenuObjectMoveMore, E_INDEX[1], "Extra");
	//
	LoadGUIMenu(MenuObjectMoveMore, MenuButton, 422.0, 146.0, CLICK_OBJMOVEMORE_TRANSFORM, E_INDEX);
	GUISetTextSize(MenuObjectMoveMore, E_INDEX[0], 76.0, 16.0); // transform button
	GUISetPlayerText(MenuObjectMoveMore, E_INDEX[1], "Transform");

	LoadGUIMenu(MenuObjectMoveMore, MenuButton, 422.0, 164.0, CLICK_OBJMOVEMORE_TOCURSOR, E_INDEX);
	GUISetTextSize(MenuObjectMoveMore, E_INDEX[0], 76.0, 16.0); // to cursor button
	GUISetPlayerText(MenuObjectMoveMore, E_INDEX[1], "Move_to_Cursor");

	LoadGUIMenu(MenuObjectMoveMore, MenuButton, 422.0, 182.0, CLICK_OBJMOVEMORE_TOGROUND, E_INDEX);
	GUISetTextSize(MenuObjectMoveMore, E_INDEX[0], 76.0, 16.0); // to ground button
	GUISetPlayerText(MenuObjectMoveMore, E_INDEX[1], "Move_to_Ground");

	LoadGUIMenu(MenuObjectMoveMore, MenuButton, 422.0, 200.0, CLICK_OBJMOVEMORE_TOFRONT, E_INDEX);
	GUISetTextSize(MenuObjectMoveMore, E_INDEX[0], 76.0, 16.0); // to front button
	GUISetPlayerText(MenuObjectMoveMore, E_INDEX[1], "Move_to_Front");

	// GROUP MENU

	MenuGroup = CreateGUI("MenuGroup");

	LoadGUIMenu(MenuGroup, MenuBox, 500.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 120.0, 199.0); // back box

	LoadGUIMenu(MenuGroup, MenuHeader, 500.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 120.0, 16.0); // header box
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Group_Menu");
	//
	LoadGUIMenu(MenuGroup, MenuButton, 502.0, 146.0, CLICK_GRP_SELALLOBJ, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 116.0, 16.0); // select all objects button
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Select_all_objects");

	LoadGUIMenu(MenuGroup, MenuButton, 502.0, 164.0, CLICK_GRP_SELGRPID, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 116.0, 16.0); // select group id button
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Select_Group_ID");

	LoadGUIMenu(MenuGroup, MenuButton, 502.0, 182.0, CLICK_GRP_CLEARSEL, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 116.0, 16.0); // clear sel button
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Clear_selection");
	//
	LoadGUIMenu(MenuGroup, MenuHeader, 500.0, 200.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 120.0, 16.0); // selection header box
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Selection");
	//
	LoadGUIMenu(MenuGroup, MenuButton, 502.0, 218.0, CLICK_GRP_SETGRPID, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 116.0, 16.0); // set group id
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Set_Group_ID");
	//
	LoadGUIMenu(MenuGroup, MenuButton, 502.0, 236.0, CLICK_GRP_ADDSELOBJ, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 116.0, 16.0); // add selected button
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Add_Selected_Object");

	LoadGUIMenu(MenuGroup, MenuText, 502.0, 254.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 22.0, 16.0); // add text
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Add");

	LoadGUIMenu(MenuGroup, MenuButton, 526.0, 254.0, CLICK_GRP_ADDOBJID, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 46.0, 16.0); // add object id button
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Object_ID");

	LoadGUIMenu(MenuGroup, MenuButton, 574.0, 254.0, CLICK_GRP_ADDRANGE, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 44.0, 16.0); // add range button
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Range");
	//
	LoadGUIMenu(MenuGroup, MenuButton, 502.0, 272.0, CLICK_GRP_REMSELOBJ, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 116.0, 16.0); // rem selected button
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Rem_Selected_Object");

	LoadGUIMenu(MenuGroup, MenuText, 502.0, 290.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 22.0, 16.0); // rem text
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Rem");

	LoadGUIMenu(MenuGroup, MenuButton, 526.0, 290.0, CLICK_GRP_REMOBJID, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 46.0, 16.0); // rem object id button
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Object_ID");

	LoadGUIMenu(MenuGroup, MenuButton, 574.0, 290.0, CLICK_GRP_REMRANGE, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 44.0, 16.0); // rem range button
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Range");
	//
	LoadGUIMenu(MenuGroup, MenuButton, 502.0, 308.0, CLICK_GRP_TRANSFORM, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 116.0, 16.0); // transform button
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Transform_Menu");

	// GROUP-MOVE MENU

	MenuGroupMove = CreateGUI("MenuGroupMove");

	LoadGUIMenu(MenuGroupMove, MenuBox, 500.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 120.0, 198.0); // back box

	LoadGUIMenu(MenuGroupMove, MenuHeader, 500.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 120.0, 16.0); // header box
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "Group_Movement");
	//
	LoadGUIMenu(MenuGroupMove, MenuHeaderMoreButton, 604.0, 128.0, CLICK_GRPMOVE_MORE, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // header more button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "...");

	LoadGUIMenu(MenuGroupMove, MenuHeaderButton, 579.0, 128.0, CLICK_GRPMOVE_BACK, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 25.0, 16.0); // header back button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "Back");
	//
	LoadGUIMenu(MenuGroupMove, MenuText, 502.0, 146.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 80.0, 16.0); // X text
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "X");
	GUISetAlignment(MenuGroupMove, E_INDEX[1], 1);

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 602.0, 146.0, CLICK_GRPMOVE_X_L, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // X left button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 584.0, 146.0, CLICK_GRPMOVE_X_R, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // X right button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:left");
	//
	LoadGUIMenu(MenuGroupMove, MenuText, 502.0, 164.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 80.0, 16.0); // Y text
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "Y");
	GUISetAlignment(MenuGroupMove, E_INDEX[1], 1);

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 602.0, 164.0, CLICK_GRPMOVE_Y_L, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // Y left button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 584.0, 164.0, CLICK_GRPMOVE_Y_R, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // Y right button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:left");
	//
	LoadGUIMenu(MenuGroupMove, MenuText, 502.0, 182.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 80.0, 16.0); // Z text
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "Z");
	GUISetAlignment(MenuGroupMove, E_INDEX[1], 1);

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 602.0, 182.0, CLICK_GRPMOVE_Z_L, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // Z left button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 584.0, 182.0, CLICK_GRPMOVE_Z_R, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // Z right button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:left");
	//
	LoadGUIMenu(MenuGroupMove, MenuHeader, 500.0, 200.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 120.0, 16.0); // rot header box
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "Rotation");
	//
	LoadGUIMenu(MenuGroupMove, MenuText, 502.0, 218.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 80.0, 16.0); // RX text
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "RX");
	GUISetAlignment(MenuGroupMove, E_INDEX[1], 1);

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 602.0, 218.0, CLICK_GRPMOVE_RX_L, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // RX left button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 584.0, 218.0, CLICK_GRPMOVE_RX_R, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // RX right button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:left");
	//
	LoadGUIMenu(MenuGroupMove, MenuText, 502.0, 236.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 80.0, 16.0); // RY text
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "RY");
	GUISetAlignment(MenuGroupMove, E_INDEX[1], 1);

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 602.0, 236.0, CLICK_GRPMOVE_RY_L, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // RY left button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 584.0, 236.0, CLICK_GRPMOVE_RY_R, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // RY right button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:left");
	//
	LoadGUIMenu(MenuGroupMove, MenuText, 502.0, 254.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 80.0, 16.0); // RZ text
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "RZ");
	GUISetAlignment(MenuGroupMove, E_INDEX[1], 1);

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 602.0, 254.0, CLICK_GRPMOVE_RZ_L, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // RZ left button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 584.0, 254.0, CLICK_GRPMOVE_RZ_R, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // RZ right button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:left");
	//
	LoadGUIMenu(MenuGroupMove, MenuHeader, 500.0, 272.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 120.0, 16.0); // nudge header box
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "Nudge_Settings");
	//
	LoadGUIMenu(MenuGroupMove, MenuText, 502.0, 290.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 20.0, 16.0); // nudge pos text
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "Pos");

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 602.0, 290.0, CLICK_GRPMOVE_NUDPOS_R, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // nudge pos right button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 584.0, 290.0, CLICK_GRPMOVE_NUDPOS_L, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // nudge pos left button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:left");
	//
	LoadGUIMenu(MenuGroupMove, MenuText, 502.0, 308.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 20.0, 16.0); // nudge rot text
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "Rot");

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 602.0, 308.0, CLICK_GRPMOVE_NUDROT_R, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // nudge rot right button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 584.0, 308.0, CLICK_GRPMOVE_NUDROT_L, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // nudge rot left button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:left");

	// GROUP-MOVE MORE MENU

	MenuGroupMoveMore = CreateGUI("MenuGroupMoveMore");

	LoadGUIMenu(MenuGroupMoveMore, MenuBox, 420.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMoveMore, E_INDEX[0], 80.0, 90.0); // back box

	LoadGUIMenu(MenuGroupMoveMore, MenuHeader, 420.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMoveMore, E_INDEX[0], 80.0, 16.0); // header box
	GUISetPlayerText(MenuGroupMoveMore, E_INDEX[1], "Extra");
	//
	LoadGUIMenu(MenuGroupMoveMore, MenuButton, 422.0, 146.0, CLICK_GRPMOVEMORE_TRANSFORM, E_INDEX);
	GUISetTextSize(MenuGroupMoveMore, E_INDEX[0], 76.0, 16.0); // transform button
	GUISetPlayerText(MenuGroupMoveMore, E_INDEX[1], "Transform");

	LoadGUIMenu(MenuGroupMoveMore, MenuButton, 422.0, 164.0, CLICK_GRPMOVEMORE_TOCURSOR, E_INDEX);
	GUISetTextSize(MenuGroupMoveMore, E_INDEX[0], 76.0, 16.0); // to cursor button
	GUISetPlayerText(MenuGroupMoveMore, E_INDEX[1], "Move_to_Cursor");

	LoadGUIMenu(MenuGroupMoveMore, MenuButton, 422.0, 182.0, CLICK_GRPMOVEMORE_TOGROUND, E_INDEX);
	GUISetTextSize(MenuGroupMoveMore, E_INDEX[0], 76.0, 16.0); // to ground button
	GUISetPlayerText(MenuGroupMoveMore, E_INDEX[1], "Move_to_Ground");

	LoadGUIMenu(MenuGroupMoveMore, MenuButton, 422.0, 200.0, CLICK_GRPMOVEMORE_TOFRONT, E_INDEX);
	GUISetTextSize(MenuGroupMoveMore, E_INDEX[0], 76.0, 16.0); // to front button
	GUISetPlayerText(MenuGroupMoveMore, E_INDEX[1], "Move_to_Front");

	// Create player menus

	foreach(new i : Player)
	{
		CreatePlayerMenus(i);
	}

	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid)
{
	CreatePlayerMenus(playerid);

	return Y_HOOKS_CONTINUE_RETURN_1;
}

static CreatePlayerMenus(playerid)
{
	new tmpArray[MAX_ELEMENTS][GUIDEF], tmpCount;
	
	// Set selection color
	SetPlayerGUISelectionColor(playerid, 0xFFFF00FF);
	
	// Object menu
	printf("Object menu");
	PlayerMenuObject[playerid] = PlayerCreateGUI(playerid, "MenuObject");
	
	tmpCount = CopyGUIMenuData(MenuInput, tmpArray);
	tmpArray = AdjustGUIMenuData(tmpArray, 0, .setTextSizeX = 47.0, .setTextSizeY = 16.0);
	tmpArray = AdjustGUIMenuData(tmpArray, 1, .setText = "0", .setAlignment = 2);

	PlayerLoadGUIMenu(playerid, PlayerMenuObject[playerid], tmpArray, 535.0, 164.0, CLICK_OBJ_MODEL_INPUT, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_ObjModel] = E_PLAYERINDEX[1]; // model input

	PlayerLoadGUIMenu(playerid, PlayerMenuObject[playerid], tmpArray, 535.0, 182.0, CLICK_OBJ_GROUP_INPUT, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_ObjGroup] = E_PLAYERINDEX[1]; // group input
	
	tmpCount = CopyGUIMenuData(MenuInput, tmpArray);
	tmpArray = AdjustGUIMenuData(tmpArray, 0, .setTextSizeX = 87.0, .setTextSizeY = 16.0);
	tmpArray = AdjustGUIMenuData(tmpArray, 1, .setOffX = 3.0, .setText = "N/A", .setAlignment = 1);
	
	PlayerLoadGUIMenu(playerid, PlayerMenuObject[playerid], tmpArray, 531.0, 200.0, CLICK_OBJ_NOTE_INPUT, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_ObjNote] = E_PLAYERINDEX[1]; // note input
	
	// Object move menu
	printf("Object move menu");
	PlayerMenuObjectMove[playerid] = PlayerCreateGUI(playerid, "MenuObjectMove");

	tmpCount = CopyGUIMenuData(MenuInput, tmpArray);
	tmpArray = AdjustGUIMenuData(tmpArray, 0, .setTextSizeX = 62.0, .setTextSizeY = 16.0);
	tmpArray = AdjustGUIMenuData(tmpArray, 1, .setOffX = 30.0, .setText = "0000.0000", .setAlignment = 2);
	
	PlayerLoadGUIMenu(playerid, PlayerMenuObjectMove[playerid], tmpArray, 520.0, 146.0, CLICK_OBJMOVE_X_INPUT, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_ObjX] = E_PLAYERINDEX[1]; // X input

	PlayerLoadGUIMenu(playerid, PlayerMenuObjectMove[playerid], tmpArray, 520.0, 164.0, CLICK_OBJMOVE_Y_INPUT, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_ObjY] = E_PLAYERINDEX[1]; // Y input

	PlayerLoadGUIMenu(playerid, PlayerMenuObjectMove[playerid], tmpArray, 520.0, 182.0, CLICK_OBJMOVE_Z_INPUT, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_ObjZ] = E_PLAYERINDEX[1]; // Z input

	PlayerLoadGUIMenu(playerid, PlayerMenuObjectMove[playerid], tmpArray, 520.0, 218.0, CLICK_OBJMOVE_RX_INPUT, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_ObjRX] = E_PLAYERINDEX[1]; // RX input

	PlayerLoadGUIMenu(playerid, PlayerMenuObjectMove[playerid], tmpArray, 520.0, 236.0, CLICK_OBJMOVE_RY_INPUT, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_ObjRY] = E_PLAYERINDEX[1]; // RY input

	PlayerLoadGUIMenu(playerid, PlayerMenuObjectMove[playerid], tmpArray, 520.0, 254.0, CLICK_OBJMOVE_RZ_INPUT, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_ObjRZ] = E_PLAYERINDEX[1]; // RZ input
	
	tmpArray = AdjustGUIMenuData(tmpArray, 0, .setTextSizeX = 58.0, .setTextSizeY = 16.0);
	tmpArray = AdjustGUIMenuData(tmpArray, 1, .setOffX = 28.0, .setText = "0.0", .setAlignment = 2);

	PlayerLoadGUIMenu(playerid, PlayerMenuObjectMove[playerid], tmpArray, 524.0, 308.0, CLICK_OBJMOVE_NUDPOS_INPUT, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_ObjNudPos] = E_PLAYERINDEX[1]; // nudge pos input

	PlayerLoadGUIMenu(playerid, PlayerMenuObjectMove[playerid], tmpArray, 524.0, 326.0, CLICK_OBJMOVE_NUDROT_INPUT, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_ObjNudRot] = E_PLAYERINDEX[1]; // nudge rot input
	
	// Group move menu
	printf("Group move menu");
	PlayerMenuGroupMove[playerid] = PlayerCreateGUI(playerid, "MenuGroupMove");

	tmpCount = CopyGUIMenuData(MenuInput, tmpArray);
	tmpArray = AdjustGUIMenuData(tmpArray, 0, .setTextSizeX = 58.0, .setTextSizeY = 16.0);
	tmpArray = AdjustGUIMenuData(tmpArray, 1, .setOffX = 28.0, .setText = "0.0", .setAlignment = 2);

	PlayerLoadGUIMenu(playerid, PlayerMenuGroupMove[playerid], tmpArray, 524.0, 308.0, CLICK_GRPMOVE_NUDROT_INPUT, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_GrpNudPos] = E_PLAYERINDEX[1]; // nudge rot input

	PlayerLoadGUIMenu(playerid, PlayerMenuGroupMove[playerid], tmpArray, 524.0, 290.0, CLICK_GRPMOVE_NUDPOS_INPUT, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_GrpNudRot] = E_PLAYERINDEX[1]; // nudge pos input
	
	// Bind menus
	printf("Bind menus");
	PlayerBindGUITextDraw(playerid, PlayerMenuObject[playerid], MenuObject);
	PlayerBindGUITextDraw(playerid, PlayerMenuObjectMove[playerid], MenuObjectMove);
	PlayerBindGUITextDraw(playerid, PlayerMenuGroupMove[playerid], MenuGroupMove);
	
	// Other bind menus (no ele's)
	PlayerMenuMap[playerid] = PlayerCreateGUI(playerid, "MenuMap");
	PlayerBindGUITextDraw(playerid, PlayerMenuMap[playerid], MenuMap);
	PlayerMenuObjectMoveMore[playerid] = PlayerCreateGUI(playerid, "MenuObjectMoveMore");
	PlayerBindGUITextDraw(playerid, PlayerMenuObjectMoveMore[playerid], MenuObjectMoveMore);
	PlayerMenuGroup[playerid] = PlayerCreateGUI(playerid, "MenuGroup");
	PlayerBindGUITextDraw(playerid, PlayerMenuGroup[playerid], MenuGroup);
	PlayerMenuGroupMoveMore[playerid] = PlayerCreateGUI(playerid, "MenuGroupMoveMore");
	PlayerBindGUITextDraw(playerid, PlayerMenuGroupMoveMore[playerid], MenuGroupMoveMore);
	
	// Bind menu groups
	printf("Bind all menus");
	/*PlayerMenuAll[playerid] = PlayerCreateGUI(playerid, "AllMenus");
	PlayerBindGUITextDraw(playerid, PlayerMenuAll[playerid], ToolBar);
	PlayerBindGUITextDraw(playerid, PlayerMenuAll[playerid], MenuMap);
	PlayerBindGUITextDraw(playerid, PlayerMenuAll[playerid], MenuObject);
	PlayerBindGUITextDraw(playerid, PlayerMenuAll[playerid], MenuObjectMove);
	PlayerBindGUITextDraw(playerid, PlayerMenuAll[playerid], MenuObjectMoveMore);
	PlayerBindGUITextDraw(playerid, PlayerMenuAll[playerid], MenuGroup);
	PlayerBindGUITextDraw(playerid, PlayerMenuAll[playerid], MenuGroupMove);
	PlayerBindGUITextDraw(playerid, PlayerMenuAll[playerid], MenuGroupMoveMore);*/
	
	PlayerMenuMapAll[playerid] = PlayerCreateGUI(playerid, "AllMapMenus");
	PlayerBindGUITextDraw(playerid, PlayerMenuMapAll[playerid], MenuMap);
	
	PlayerMenuObjectAll[playerid] = PlayerCreateGUI(playerid, "AllObjectMenus");
	PlayerBindGUITextDraw(playerid, PlayerMenuObjectAll[playerid], MenuObject);
	PlayerBindGUITextDraw(playerid, PlayerMenuObjectAll[playerid], MenuObjectMove);
	PlayerBindGUITextDraw(playerid, PlayerMenuObjectAll[playerid], MenuObjectMoveMore);
	
	PlayerMenuGroupAll[playerid] = PlayerCreateGUI(playerid, "AllGroupMenus");
	PlayerBindGUITextDraw(playerid, PlayerMenuGroupAll[playerid], MenuGroup);
	PlayerBindGUITextDraw(playerid, PlayerMenuGroupAll[playerid], MenuGroupMove);
	PlayerBindGUITextDraw(playerid, PlayerMenuGroupAll[playerid], MenuGroupMoveMore);
	
	/*PlayerMenuSubmenuAll[playerid] = PlayerCreateGUI(playerid, "AllSubmenus");
	PlayerBindGUITextDraw(playerid, PlayerMenuSubmenuAll[playerid], MenuObjectMoveMore);
	PlayerBindGUITextDraw(playerid, PlayerMenuSubmenuAll[playerid], MenuGroupMoveMore);*/
	
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(IsFlyMode(playerid) && (newkeys & KEY_WALK))
	{
		//if(!EditingMode[playerid])
		{
			ShowGUIMenu(playerid, ToolBar);
			PlayerSelectGUITextDraw(playerid);
			return Y_HOOKS_BREAK_RETURN_1;
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_0;
}

HideFlymodeInterface(playerid)
{
	HideGUIMenu(playerid, ToolBar);
	PlayerHideGUIMenu(playerid, PlayerMenuMap[playerid]);
	PlayerHideGUIMenu(playerid, PlayerMenuObject[playerid]);
	PlayerHideGUIMenu(playerid, PlayerMenuObjectMove[playerid]);
	PlayerHideGUIMenu(playerid, PlayerMenuObjectMoveMore[playerid]);
	PlayerHideGUIMenu(playerid, PlayerMenuGroup[playerid]);
	PlayerHideGUIMenu(playerid, PlayerMenuGroupMove[playerid]);
	PlayerHideGUIMenu(playerid, PlayerMenuGroupMoveMore[playerid]);
	
	PlayerCancelSelectGUITextDraw(playerid);
	return 1;
}

OnGUIClick:ToolBar(playerid, group, gindex, pindex)
{
	switch(group)
	{
		case CLICK_EXIT_MENU:
		{
			HideFlymodeInterface(playerid);
		}
		case CLICK_TOOL_MAPMENU:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuObjectAll[playerid]);
			PlayerHideGUIMenu(playerid, PlayerMenuGroupAll[playerid]);
			
			PlayerHideGUIMenu(playerid, PlayerMenuObject[playerid]);
			PlayerHideGUIMenu(playerid, PlayerMenuGroupMove[playerid]);
			PlayerHideGUIMenu(playerid, PlayerMenuObjectMove[playerid]);
			
			wait_ms(25);
			
			PlayerShowGUIMenu(playerid, PlayerMenuMap[playerid], true);
			PlayerSelectGUITextDraw(playerid);
		}
		case CLICK_TOOL_OBJMENU:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuMapAll[playerid]);
			PlayerHideGUIMenu(playerid, PlayerMenuGroupAll[playerid]);
			
			PlayerHideGUIMenu(playerid, PlayerMenuGroupMove[playerid]);
			PlayerHideGUIMenu(playerid, PlayerMenuObjectMove[playerid]);
			
			wait_ms(25);
			
			PlayerShowGUIMenu(playerid, PlayerMenuObject[playerid], true);
			PlayerSelectGUITextDraw(playerid);
		}
		case CLICK_TOOL_GRPMENU:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuMapAll[playerid]);
			PlayerHideGUIMenu(playerid, PlayerMenuObjectAll[playerid]);
			
			PlayerHideGUIMenu(playerid, PlayerMenuObject[playerid]);
			PlayerHideGUIMenu(playerid, PlayerMenuGroupMove[playerid]);
			PlayerHideGUIMenu(playerid, PlayerMenuObjectMove[playerid]);
			
			wait_ms(25);
			
			PlayerShowGUIMenu(playerid, PlayerMenuGroup[playerid], true);
			PlayerSelectGUITextDraw(playerid);
		}
		case CLICK_TOOL_MODSEARCH:
		{
			inline ModelSearch(pid, dialogid, response, listitem, string:text[])
			{
				#pragma unused listitem, dialogid, pid, text
				
				if(response) {
					BroadcastCommand(playerid, sprintf("/osearch %s", text));
				}
			}
			Dialog_ShowCallback(playerid, using inline ModelSearch, DIALOG_STYLE_INPUT, "Texture Studio", "Search for a model name", "Ok", "Cancel");
		}
		case CLICK_TOOL_TEXSEARCH:
		{
			inline TextureSearch(pid, dialogid, response, listitem, string:text[])
			{
				#pragma unused listitem, dialogid, pid, text
				
				if(response) {
					BroadcastCommand(playerid, sprintf("/tsearch %s", text));
				}
			}
			Dialog_ShowCallback(playerid, using inline TextureSearch, DIALOG_STYLE_INPUT, "Texture Studio", "Search for a texture name", "Ok", "Cancel");
		}
		default:
		{
			printf("[DEBUGG] %i, %i, %i, %i", playerid, group, gindex, pindex);
		}
	}
	return 1;
}

OnGUIClick:MenuMap(playerid, group, gindex, pindex)
{
	switch(group)
	{
		case CLICK_EXIT_MENU:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuMapAll[playerid]);
		}
		case CLICK_MAP_NEWMAP:
		{
			//TODO test
			BroadcastCommand(playerid, "/newmap");
		}
		case CLICK_MAP_LOADMAP:
		{
			//TODO test
			BroadcastCommand(playerid, "/loadmap");
		}
		case CLICK_MAP_RENAMEMAP:
		{
			//TODO test
			BroadcastCommand(playerid, "/renamemap");
		}
		case CLICK_MAP_IMPORTMAP:
		{
			//TODO test
			BroadcastCommand(playerid, "/importmap");
		}
		case CLICK_MAP_EXPORTMAP:
		{
			//TODO test
			BroadcastCommand(playerid, "/export");
		}
		default:
		{
			printf("[DEBUGG] %i, %i, %i, %i", playerid, group, gindex, pindex);
		}
	}
	return 1;
}

OnGUIClick:MenuObject(playerid, group, gindex, pindex)
{
	switch(group)
	{
		case CLICK_EXIT_MENU:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuObjectAll[playerid]);
		}
		case CLICK_OBJ_CLONE:
		{
			//TODO test
			BroadcastCommand(playerid, "/clone");
		}
		case CLICK_OBJ_CREATE:
		{
			//TODO test
			inline ObjectCreate(pid, dialogid, response, listitem, string:text[])
			{
				#pragma unused listitem, dialogid, pid, text
				
				if(response) {
					BroadcastCommand(playerid, sprintf("/cobject %s", text));
				}
			}
			Dialog_ShowCallback(playerid, using inline ObjectCreate, DIALOG_STYLE_INPUT, "Texture Studio", "Enter new object model ID.", "Ok", "Cancel");
		}
		case CLICK_OBJ_DELETE:
		{
			//TODO test
			BroadcastCommand(playerid, "/dobject");
		}
		case CLICK_OBJ_GROUP_L:
		{
			//TODO update text
			EditCheck(playerid);
			BroadcastCommand(playerid, sprintf("/ogroup %i", ObjectData[CurrObject[playerid]][oGroup] - 1));
		}
		case CLICK_OBJ_GROUP_R:
		{
			//TODO update text
			EditCheck(playerid);
			BroadcastCommand(playerid, sprintf("/ogroup %i", ObjectData[CurrObject[playerid]][oGroup] + 1));
		}
		case CLICK_OBJ_MODEL_L:
		{
			//TODO update text
			EditCheck(playerid);
			BroadcastCommand(playerid, sprintf("/oswap %i", ObjectData[CurrObject[playerid]][oModel] - 1));
		}
		case CLICK_OBJ_MODEL_R:
		{
			//TODO update text
			EditCheck(playerid);
			BroadcastCommand(playerid, sprintf("/oswap %i", ObjectData[CurrObject[playerid]][oModel] + 1));
		}
		case CLICK_OBJ_TRANSFORM:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuObject[playerid]);
			wait_ms(25);
			
			PlayerShowGUIMenu(playerid, PlayerMenuObjectMove[playerid], true);
			PlayerSelectGUITextDraw(playerid);
		}
		default:
		{
			printf("[DEBUGG] %i, %i, %i, %i", playerid, group, gindex, pindex);
		}
	}
	return 1;
}

OnPlayerGUIClick:MenuObject(playerid, group, gindex, pindex)
{
	printf("OnPlayerGUIClick:MenuObject(%i, %i, %i, %i)", playerid, group, gindex, pindex);
	switch(group)
	{
		case CLICK_OBJ_GROUP_INPUT:
		{
			//TODO update text
			inline ObjectGroupSet(pid, dialogid, response, listitem, string:text[])
			{
				#pragma unused listitem, dialogid, pid, text
				
				if(response) {
					BroadcastCommand(playerid, sprintf("/ogroup %s", text));
				}
			}
			Dialog_ShowCallback(playerid, using inline ObjectGroupSet, DIALOG_STYLE_INPUT, "Texture Studio", "Enter new group ID.", "Ok", "Cancel");
		}
		case CLICK_OBJ_MODEL_INPUT:
		{
			//TODO update text
			inline ObjectModelSet(pid, dialogid, response, listitem, string:text[])
			{
				#pragma unused listitem, dialogid, pid, text
				
				if(response) {
					BroadcastCommand(playerid, sprintf("/oswap %s", text));
				}
			}
			Dialog_ShowCallback(playerid, using inline ObjectModelSet, DIALOG_STYLE_INPUT, "Texture Studio", "Enter new model ID.", "Ok", "Cancel");
		}
		case CLICK_OBJ_NOTE_INPUT:
		{
			EditCheck(playerid);
			
			//TODO update text
			inline ObjectNoteSet(pid, dialogid, response, listitem, string:text[])
			{
				#pragma unused listitem, dialogid, pid, text
				
				if(response) {
					BroadcastCommand(playerid, sprintf("/onote %i %s", CurrObject[playerid], text));
				}
			}
			Dialog_ShowCallback(playerid, using inline ObjectNoteSet, DIALOG_STYLE_INPUT, "Texture Studio", "Enter new note.", "Ok", "Cancel");
		}
		default:
		{
			printf("[DEBUGG] %i, %i, %i, %i", playerid, group, gindex, pindex);
		}
	}
	return 1;
}

OnGUIClick:MenuObjectMove(playerid, group, gindex, pindex)
{
	switch(group)
	{
		case CLICK_EXIT_MENU:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuObjectAll[playerid]);
		}
		case CLICK_OBJMOVE_MORE:
		{
			PlayerShowGUIMenu(playerid, PlayerMenuObjectMoveMore[playerid], true);
			PlayerSelectGUITextDraw(playerid);
		}
		case CLICK_OBJMOVE_BACK:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuObjectMove[playerid]);
			PlayerHideGUIMenu(playerid, PlayerMenuObjectMoveMore[playerid]);
			wait_ms(25);
			
			PlayerShowGUIMenu(playerid, PlayerMenuObject[playerid], true);
			PlayerSelectGUITextDraw(playerid);
		}
		case CLICK_OBJMOVE_X_L:
		{
			//TODO 
		}
		case CLICK_OBJMOVE_X_R:
		{
			//TODO 
		}
		case CLICK_OBJMOVE_Y_L:
		{
			//TODO 
		}
		case CLICK_OBJMOVE_Y_R:
		{
			//TODO 
		}
		case CLICK_OBJMOVE_Z_L:
		{
			//TODO 
		}
		case CLICK_OBJMOVE_Z_R:
		{
			//TODO 
		}
		case CLICK_OBJMOVE_RX_L:
		{
			//TODO 
		}
		case CLICK_OBJMOVE_RX_R:
		{
			//TODO 
		}
		case CLICK_OBJMOVE_RY_L:
		{
			//TODO 
		}
		case CLICK_OBJMOVE_RY_R:
		{
			//TODO 
		}
		case CLICK_OBJMOVE_RZ_L:
		{
			//TODO 
		}
		case CLICK_OBJMOVE_RZ_R:
		{
			//TODO 
		}
		case CLICK_OBJMOVE_RESROT:
		{
			//TODO 
		}
		case CLICK_OBJMOVE_NUDPOS_L:
		{
			//TODO 
		}
		case CLICK_OBJMOVE_NUDPOS_R:
		{
			//TODO 
		}
		case CLICK_OBJMOVE_NUDROT_L:
		{
			//TODO 
		}
		case CLICK_OBJMOVE_NUDROT_R:
		{
			//TODO 
		}
		default:
		{
			printf("[DEBUGG] %i, %i, %i, %i", playerid, group, gindex, pindex);
		}
	}
	return 1;
}

OnPlayerGUIClick:MenuObjectMove(playerid, group, gindex, pindex)
{
	switch(group)
	{
		case CLICK_OBJMOVE_X_INPUT:
		{
			//TODO 
		}
		case CLICK_OBJMOVE_Y_INPUT:
		{
			//TODO 
		}
		case CLICK_OBJMOVE_Z_INPUT:
		{
			//TODO 
		}
		case CLICK_OBJMOVE_RX_INPUT:
		{
			//TODO 
		}
		case CLICK_OBJMOVE_RY_INPUT:
		{
			//TODO 
		}
		case CLICK_OBJMOVE_RZ_INPUT:
		{
			//TODO 
		}
		case CLICK_OBJMOVE_NUDPOS_INPUT:
		{
			//TODO 
		}
		case CLICK_OBJMOVE_NUDROT_INPUT:
		{
			//TODO 
		}
		default:
		{
			printf("[DEBUGG] %i, %i, %i, %i", playerid, group, gindex, pindex);
		}
	}
	return 1;
}

OnGUIClick:MenuObjectMoveMore(playerid, group, gindex, pindex)
{
	switch(group)
	{
		case CLICK_EXIT_MENU:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuObjectMoveMore[playerid]);
		}
		case CLICK_OBJMOVEMORE_TOCURSOR:
		{
			//TODO
		}
		case CLICK_OBJMOVEMORE_TOFRONT:
		{
			//TODO
		}
		case CLICK_OBJMOVEMORE_TOGROUND:
		{
			//TODO
		}
		case CLICK_OBJMOVEMORE_TRANSFORM:
		{
			//TODO
		}
		default:
		{
			printf("[DEBUGG] %i, %i, %i, %i", playerid, group, gindex, pindex);
		}
	}
	return 1;
}

OnGUIClick:MenuGroup(playerid, group, gindex, pindex)
{
	switch(group)
	{
		case CLICK_EXIT_MENU:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuGroupAll[playerid]);
		}
		case CLICK_GRP_CLEARSEL:
		{
			//TODO
		}
		case CLICK_GRP_SELALLOBJ:
		{
			//TODO
		}
		case CLICK_GRP_SELGRPID:
		{
			//TODO
		}
		case CLICK_GRP_ADDOBJID:
		{
			//TODO
		}
		case CLICK_GRP_ADDRANGE:
		{
			//TODO
		}
		case CLICK_GRP_ADDSELOBJ:
		{
			//TODO
		}
		case CLICK_GRP_REMOBJID:
		{
			//TODO
		}
		case CLICK_GRP_REMRANGE:
		{
			//TODO
		}
		case CLICK_GRP_REMSELOBJ:
		{
			//TODO
		}
		case CLICK_GRP_SETGRPID:
		{
			//TODO
		}
		case CLICK_GRP_TRANSFORM:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuGroup[playerid]);
			wait_ms(25);
			
			PlayerShowGUIMenu(playerid, PlayerMenuGroupMove[playerid], true);
			PlayerSelectGUITextDraw(playerid);
		}
		default:
		{
			printf("[DEBUGG] %i, %i, %i, %i", playerid, group, gindex, pindex);
		}
	}
	return 1;
}

OnGUIClick:MenuGroupMove(playerid, group, gindex, pindex)
{
	switch(group)
	{
		case CLICK_EXIT_MENU:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuGroupAll[playerid]);
		}
		case CLICK_GRPMOVE_MORE:
		{
			PlayerShowGUIMenu(playerid, PlayerMenuGroupMoveMore[playerid], true);
		}
		case CLICK_GRPMOVE_BACK:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuGroupMove[playerid]);
			PlayerHideGUIMenu(playerid, PlayerMenuGroupMoveMore[playerid]);
			wait_ms(25);
			
			PlayerShowGUIMenu(playerid, PlayerMenuGroup[playerid], true);
			PlayerSelectGUITextDraw(playerid);
		}
		case CLICK_GRPMOVE_X_L:
		{
			//TODO
		}
		case CLICK_GRPMOVE_X_R:
		{
			//TODO
		}
		case CLICK_GRPMOVE_Y_L:
		{
			//TODO
		}
		case CLICK_GRPMOVE_Y_R:
		{
			//TODO
		}
		case CLICK_GRPMOVE_Z_L:
		{
			//TODO
		}
		case CLICK_GRPMOVE_Z_R:
		{
			//TODO
		}
		case CLICK_GRPMOVE_RX_L:
		{
			//TODO
		}
		case CLICK_GRPMOVE_RX_R:
		{
			//TODO
		}
		case CLICK_GRPMOVE_RY_L:
		{
			//TODO
		}
		case CLICK_GRPMOVE_RY_R:
		{
			//TODO
		}
		case CLICK_GRPMOVE_RZ_L:
		{
			//TODO
		}
		case CLICK_GRPMOVE_RZ_R:
		{
			//TODO
		}
		case CLICK_GRPMOVE_NUDPOS_L:
		{
			//TODO
		}
		case CLICK_GRPMOVE_NUDPOS_R:
		{
			//TODO
		}
		case CLICK_GRPMOVE_NUDROT_L:
		{
			//TODO
		}
		case CLICK_GRPMOVE_NUDROT_R:
		{
			//TODO
		}
		default:
		{
			printf("[DEBUGG] %i, %i, %i, %i", playerid, group, gindex, pindex);
		}
	}
	return 1;
}

OnPlayerGUIClick:MenuGroupMove(playerid, group, gindex, pindex)
{
	switch(group)
	{
		case CLICK_GRPMOVE_NUDPOS_INPUT:
		{
			//TODO
		}
		case CLICK_GRPMOVE_NUDROT_INPUT:
		{
			//TODO
		}
		default:
		{
			printf("[DEBUGG] %i, %i, %i, %i", playerid, group, gindex, pindex);
		}
	}
	return 1;
}

OnGUIClick:MenuGroupMoveMore(playerid, group, gindex, pindex)
{
	switch(group)
	{
		case CLICK_EXIT_MENU:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuGroupMoveMore[playerid]);
		}
		case CLICK_GRPMOVEMORE_TOCURSOR:
		{
			//TODO
		}
		case CLICK_GRPMOVEMORE_TOFRONT:
		{
			//TODO
		}
		case CLICK_GRPMOVEMORE_TOGROUND:
		{
			//TODO
		}
		case CLICK_GRPMOVEMORE_TRANSFORM:
		{
			//TODO
		}
		default:
		{
			printf("[DEBUGG] %i, %i, %i, %i", playerid, group, gindex, pindex);
		}
	}
	return 1;
}

