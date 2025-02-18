package;

#if android
import android.content.Context;
#end
import debug.FPSCounter;
import flixel.FlxGame;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.display.StageScaleMode;

#if HSCRIPT_ALLOWED
import crowplexus.iris.Iris;
import psychlua.HScript.HScriptInfos;
#end
#if linux
import lime.graphics.Image;
#end
#if desktop
import backend.config.ALSoftConfig; // Just to make sure DCE doesn't remove this, since it's not directly referenced anywhere else
#end
import backend.gameplay.Highscore;

// NATIVE API STUFF, YOU CAN IGNORE THIS AND SCROLL //
#if (linux && !debug)
@:cppInclude('./external/gamemode_client.h')
@:cppFileCode('#define GAMEMODE_AUTO')
#end
#if windows
@:buildXml('
<target id="haxe">
	<lib name="wininet.lib" if="windows" />
	<lib name="dwmapi.lib" if="windows" />
</target>
')
@:cppFileCode('
#include <windows.h>
#include <winuser.h>
#pragma comment(lib, "Shell32.lib")
extern "C" HRESULT WINAPI SetCurrentProcessExplicitAppUserModelID(PCWSTR AppID);
')
#end

/**
 * The main class that starts the entire game.
 * Other than changing info in the `_game` variable, you will not really
 * need to even touch this file. If you want to change things in the intro, then
 * modify the `TitleState.hx` file; otherwise, your code should go into your states.
 */
class Main extends Sprite
{
	/**
	 * JSON object for holding all of the info about the game.
	 */
	private var _game = {
		// Window width (you can set this to 0 to use the default width in the Project.xml file)
		width: 1280,
		// Window height (you can set this to 0 to use the default height in the Project.xml file)
		height: 720,
		// The entrypoint of the game
		initialState: InitState, 
		// The default framerate (how fast the game should update)
		framerate: 60, 
		// Should the HaxeFlixel splash screen be skipped?
		skipSplash: true, 
		// Should the game start in fullscreen?
		startFullscreen: false
	};

	/**
	 * The FPS counter you see in the top left corner of your screen.
	 */
	public static var fpsVar:FPSCounter;

	// ---------------------------------------------------------
	// You can pretty much ignore everything from here on :p
	// ---------------------------------------------------------

	public static function main():Void
	{
		// Add the Main class to the current library
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();

		#if windows
		// DPI scaling fix for windows
		// this shouldn't be needed for other systems
		// Credit to YoshiCrafter29 for finding this function
		untyped __cpp__("SetProcessDPIAware();");
		#end

		// Credits to MAJigsaw77 (he's the OG author for this code)
		// This changes the current working directory based on what
		// mobile platform the game is being run on
		#if android
		Sys.setCwd(Path.addTrailingSlash(Context.getExternalFilesDir()));
		#elseif ios
		Sys.setCwd(lime.system.System.applicationStorageDirectory);
		#end

		#if VIDEOS_ALLOWED
		hxvlc.util.Handle.init(#if (hxvlc >= "1.8.0") ['--no-lua'] #end);
		#end

		#if LUA_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

		FlxG.save.bind('funkin', CoolUtil.getSavePath());
		Highscore.load();

		#if HSCRIPT_ALLOWED
		Iris.warn = function(x, ?pos:haxe.PosInfos)
		{
			Iris.logLevel(WARN, x, pos);
			var newPos:HScriptInfos = cast pos;
			if (newPos.showLine == null)
				newPos.showLine = true;
			var msgInfo:String = (newPos.funcName != null ? '(${newPos.funcName}) - ' : '') + '${newPos.fileName}:';
			#if LUA_ALLOWED
			if (newPos.isLua == true)
			{
				msgInfo += 'HScript:';
				newPos.showLine = false;
			}
			#end
			if (newPos.showLine == true)
			{
				msgInfo += '${newPos.lineNumber}:';
			}
			msgInfo += ' $x';
			if (PlayState.instance != null)
				PlayState.instance.addTextToDebug('WARNING: $msgInfo', FlxColor.YELLOW);
		}
		Iris.error = function(x, ?pos:haxe.PosInfos)
		{
			Iris.logLevel(ERROR, x, pos);
			var newPos:HScriptInfos = cast pos;
			if (newPos.showLine == null)
				newPos.showLine = true;
			var msgInfo:String = (newPos.funcName != null ? '(${newPos.funcName}) - ' : '') + '${newPos.fileName}:';
			#if LUA_ALLOWED
			if (newPos.isLua == true)
			{
				msgInfo += 'HScript:';
				newPos.showLine = false;
			}
			#end
			if (newPos.showLine == true)
			{
				msgInfo += '${newPos.lineNumber}:';
			}
			msgInfo += ' $x';
			if (PlayState.instance != null)
				PlayState.instance.addTextToDebug('ERROR: $msgInfo', FlxColor.RED);
		}
		Iris.fatal = function(x, ?pos:haxe.PosInfos)
		{
			Iris.logLevel(FATAL, x, pos);
			var newPos:HScriptInfos = cast pos;
			if (newPos.showLine == null)
				newPos.showLine = true;
			var msgInfo:String = (newPos.funcName != null ? '(${newPos.funcName}) - ' : '') + '${newPos.fileName}:';
			#if LUA_ALLOWED
			if (newPos.isLua == true)
			{
				msgInfo += 'HScript:';
				newPos.showLine = false;
			}
			#end
			if (newPos.showLine == true)
			{
				msgInfo += '${newPos.lineNumber}:';
			}
			msgInfo += ' $x';
			if (PlayState.instance != null)
				PlayState.instance.addTextToDebug('FATAL: $msgInfo', 0xFFBB0000);
		}
		#end

		#if LUA_ALLOWED Lua.set_callbacks_function(cpp.Callable.fromStaticFunction(psychlua.CallbackHandler.call)); #end
		Controls.instance = new Controls();
		ClientPrefs.loadDefaultKeys();
		#if ACHIEVEMENTS_ALLOWED Achievements.load(); #end

		// Add the whole funkin game
		addChild(new FlxGame(_game.width, _game.height, _game.initialState, _game.framerate, _game.framerate, _game.skipSplash, _game.startFullscreen));

		// Add the FPS counter to the game
		// (if the platform isn't on mobile)
		#if !mobile
		fpsVar = new FPSCounter(10, 3, 0xFFFFFF);
		addChild(fpsVar);
		Lib.current.stage.align = "tl";
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		if (fpsVar != null)
		{
			fpsVar.visible = ClientPrefs.data.showFPS;
		}
		#end
	}
}
