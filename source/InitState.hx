package;

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
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

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

        // Fullscreen
        FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, (event) ->
        {
            if (Controls.instance.FULLSCREEN) 
            {
                FlxG.fullscreen = !FlxG.fullscreen;
            }
        });
		#end

		// Switch to the title after everything has loaded
		FlxG.switchState(() -> new TitleState());
	}
}
