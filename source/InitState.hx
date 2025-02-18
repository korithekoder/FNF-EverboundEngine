package;

#if CRASH_HANDLER
import haxe.CallStack;
import haxe.CallStack.StackItem;
import haxe.io.Path;
import openfl.events.UncaughtErrorEvent;
#end

import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.KeyboardEvent;
import lime.app.Application;
import states.TitleState;
import states.StoryMenuState;
import backend.util.CacheUtil;
import flixel.FlxState;

/**
 * State for setting up the game before the intro starts.
 */
class InitState extends FlxState
{
	override function create()
	{
		super.create();

		// Clear up memory
		PathsUtil.clearStoredMemory();
		PathsUtil.clearUnusedMemory();

		// Load the player's settings
		if (!CacheUtil.isInitialized)
		{
			ClientPrefs.loadPrefs();
			Language.reloadPhrases();
		}

		// Set fullscreen based on whether or not
		// the player had it set last
		if (!CacheUtil.isInitialized)
		{
			if (FlxG.save.data != null && FlxG.save.data.fullscreen)
			{
				FlxG.fullscreen = FlxG.save.data.fullscreen;
			}
		}

		if (FlxG.save.data.weekCompleted != null)
		{
			StoryMenuState.weekCompleted = FlxG.save.data.weekCompleted;
		}

		// Hide the mouse until the main menu
		FlxG.mouse.visible = false;

		// Set the cursor to be the dedicated system one
		FlxG.mouse.useSystemCursor = true;

		// -------------------
		//   EVENT LISTENERS
		// -------------------

		// Increase/decrease the volume when the game loses focus
		// (This will only apply if the player has the setting
		// "Minimize Volume on Lost Focus"/minimizeVolume turned ON)
		#if desktop
		Application.current.window.onFocusIn.add(() ->
		{
			FlxTween.num(FlxG.sound.volume, CacheUtil.lastVolumeUsed, 0.3, {type: FlxTween.ONESHOT}, (v) ->
			{
				FlxG.sound.volume = v;
			});
		});
		Application.current.window.onFocusOut.add(() ->
		{
			CacheUtil.lastVolumeUsed = FlxG.sound.volume;
			if (ClientPrefs.data.minimizeVolume)
			{
				CacheUtil.lastVolumeUsed = FlxG.sound.volume;
				FlxTween.num(FlxG.sound.volume, 0.05, 0.3, {type: FlxTween.ONESHOT}, (v) ->
				{
					FlxG.sound.volume = v;
				});
			}
		});

		// Fullscreen :sparkles:
		FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, (event) ->
		{
			if (Controls.instance.FULLSCREEN)
			{
				FlxG.fullscreen = !FlxG.fullscreen;
			}
		});
		#end

		// Set the icon as a .png image if
		// the platform is on Linux
		#if linux
		var icon = Image.fromFile("icon.png");
		Lib.current.stage.window.setIcon(icon);
		#end

		// Turn off auto pausing for HTML5
		#if html5
		FlxG.autoPause = false;
		#end

		// Timestep and lost focus stuff :p
		FlxG.fixedTimestep = false;
		FlxG.game.focusLostFramerate = 60;
		FlxG.keys.preventDefaultKeys = [TAB];

		// Crash handler stuff
		#if CRASH_HANDLER
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, _onCrash);
		#end

		// Setup the Discord rich presence
		#if DISCORD_ALLOWED
		DiscordClient.prepare();
		#end

		// Shader coords fix
		FlxG.signals.gameResized.add(function(w, h)
		{
			if (FlxG.cameras != null)
			{
				for (cam in FlxG.cameras.list)
				{
					if (cam != null && cam.filters != null)
						_resetSpriteCache(cam.flashSprite);
				}
			}

			if (FlxG.game != null)
				_resetSpriteCache(FlxG.game);
		});

		// Switch to the title after everything has loaded
		FlxG.switchState(() -> new TitleState());
	}

	private static function _resetSpriteCache(sprite:Sprite):Void
	{
		@:privateAccess {
			sprite.__cacheBitmap = null;
			sprite.__cacheBitmapData = null;
		}
	}

	// Code was entirely made by sqirra-rng for their fnf engine named "Izzy Engine", big props to them!!!
	// Very cool person for real they don't get enough credit for their work
	#if CRASH_HANDLER
	private function _onCrash(e:UncaughtErrorEvent):Void
	{
		var errMsg:String = "";
		var path:String;
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);
		var dateNow:String = Date.now().toString();

		dateNow = dateNow.replace(" ", "_");
		dateNow = dateNow.replace(":", "'");

		path = "./crash/" + "EverboundEngine_" + dateNow + ".txt";

		for (stackItem in callStack)
		{
			switch (stackItem)
			{
				case FilePos(s, file, line, column):
					errMsg += file + " (line " + line + ")\n";
				default:
					Sys.println(stackItem);
			}
		}

		errMsg += "\nUncaught Error: " + e.error;
		// PLEASE READ IF YOU ARE A MODDER!!
		// If you are modding the game directly from the source, then you will most likely want to remove the provided link
		// Otherwise, modify it to your mod's GitHub repository or whatever website you hold your project on
		#if officialBuild
		errMsg += "\nPlease report this error to the GitHub page: https://github.com/korithekoder/FNF-EverboundEngine";
		#end
		errMsg += "\n\n> Crash Handler written by: sqirra-rng";

		if (!FileSystem.exists("./crash/"))
			FileSystem.createDirectory("./crash/");

		File.saveContent(path, errMsg + "\n");

		Sys.println(errMsg);
		Sys.println("Crash dump saved in " + Path.normalize(path));

		Application.current.window.alert(errMsg, "Error!");
		#if DISCORD_ALLOWED
		DiscordClient.shutdown();
		#end
		Sys.exit(1);
	}
	#end
}
