package backend.data;

import backend.util.CacheUtil;
import flixel.util.FlxSave;
import flixel.input.keyboard.FlxKey;
import flixel.input.gamepad.FlxGamepadInputID;

/**
 * Class that holds all of the options that can be changed in-game.
 * Since it has the `@:structInit` annotation, it will automatically be converted
 * to a JSON/Dynamic object, so you can add whatever options you want and it will be
 * added to the game. To make your option toggable in the options menu, check out the
 * `backend.options` package.
 * 
 * If you would like to access these options in your own code, you can do so by
 * typing `ClientPrefs.data.yourOptionHere` and use it however you want from there.
 * Note that these are not meant to be changed manually, they are only for access reasons.
 */
@:structInit class SaveVariables
{
	/**
	 * Should the arrows fall down or up?
	 */
	public var downScroll:Bool = false;

	/**
	 * Should the strumline be in the middle?
	 */
	public var middleScroll:Bool = false;

	/**
	 * Should the opponent's notes be visible?
	 */
	public var opponentStrums:Bool = true;

	/**
	 * Should the FPS counter be visible?
	 */
	public var showFPS:Bool = true;

	/**
	 * Should the game use flashing lights?
	 */
	public var flashing:Bool = true;

	/**
	 * Should the game automatically stop entirely when it loses focus?
	 */
	public var autoPause:Bool = false;

	/**
	 * Should the game smooth out lines on images?
	 */
	public var antialiasing:Bool = true;

	/**
	 * The note design that is used in gameplay.
	 */
	public var noteSkin:String = 'Default';

	/**
	 * The splash design that is used in gameplay.
	 */
	public var splashSkin:String = 'Vanilla';

	/**
	 * The transparency of the splash skin when a "Sick!" note is hit.
	 */
	public var splashAlpha:Float = 0.6;

	/**
	 * Should the game make the graphics look like they're from the 2000's?
	 */
	public var lowQuality:Bool = false;

	/**
	 * Should the game use shaders?
	 */
	public var shaders:Bool = true;

	/**
	 * Should the game pre-load everything for faster song restarts?
	 */
	public var cacheOnGPU:Bool = #if !switch false #else true #end; // GPU Caching made by Raltyro!

	/**
	 * How fast the game should update.
	 */
	public var framerate:Int = 60;

	/**
	 * Should the camera zoom in certain songs?
	 */
	public var camZooms:Bool = true;

	/**
	 * Should the game hide most of the HUD elements?
	 */
	public var hideHud:Bool = false;

	/**
	 * Set the note offset.
	 */
	public var noteOffset:Int = 0;

	/**
	 * The colors that each arrow is in non-pixel stages and songs.
	 */
	public var arrowRGB:Array<Array<FlxColor>> = [
		[0xFFC24B99, 0xFFFFFFFF, 0xFF3C1F56],
		[0xFF00FFFF, 0xFFFFFFFF, 0xFF1542B7],
		[0xFF12FA05, 0xFFFFFFFF, 0xFF0A4447],
		[0xFFF9393F, 0xFFFFFFFF, 0xFF651038]
	];

	/**
	 * The colors that each arrow is in pixelated stages and songs.
	 */
	public var arrowRGBPixel:Array<Array<FlxColor>> = [
		[0xFFE276FF, 0xFFFFF9FF, 0xFF60008D],
		[0xFF3DCAFF, 0xFFF4FFFF, 0xFF003060],
		[0xFF71E300, 0xFFF6FFE6, 0xFF003100],
		[0xFFFF884E, 0xFFFFFAF5, 0xFF6C0000]
	];

	/**
	 * Should the game not count a miss if the user presses a strum note and there are no notes present?
	 */
	public var ghostTapping:Bool = true;

	/**
	 * The type of time to be displayed for the song length.
	 */
	public var timeBarType:String = 'Time Left';

	/**
	 * Should the score text bounce when a note is hit?
	 */
	public var scoreZoom:Bool = true;

	/**
	 * Should the reset button be disabled?
	 */
	public var noReset:Bool = false;

	/**
	 * How visible the health bar should be.
	 */
	public var healthBarAlpha:Float = 1;

	/**
	 * Volume for the hit sound that plays when the user hits a note.
	 */
	public var hitsoundVolume:Float = 0;

	/**
	 * The music that plays when the game is paused.
	 */
	public var pauseMusic:String = 'Tea Time';

	/**
	 * Should the game display a message if there is a new update for the Everbound Engine?
	 */
	public var checkForUpdates:Bool = true;

	/**
	 * Should the game use combo stacking?
	 */
	public var comboStacking:Bool = true;

	/**
	 * Settings that change actual gameplay, such as
	 * instakill (set your health to 0 if you miss a note), how much
	 * health you gain/lose when notes are hit/missed, etc.
	 */
	public var gameplaySettings:Map<String, Dynamic> = [
		'scrollspeed' => 1.0,
		'scrolltype' => 'multiplicative',
		// For anyone reading this,
		// "amod" is multiplicative speed mod,
		// "cmod" is constant speed mod, and
		// "xmod" is BPM (beats per minute) based speed mod
		//
		// amod = chartSpeed * multiplier
		// cmod = constantSpeed = chartSpeed
		// xmod = basing the speed on the BPM
		// iirc = (beatsPerSecond * (conductorToNoteDifference / 1000)) * noteSize
		//
		// BPS (beats per second) is calculated by BPM / 60
		// Oh yeah, and you'd have to actually convert the difference to seconds which is already done, because this is based on beats and shit
		// Lastly, when you calculate the BPS divide it by the songSpeed or rate because it wont scroll correctly when speeds exist
		'songspeed' => 1.0,
		'healthgain' => 1.0,
		'healthloss' => 1.0,
		'instakill' => false,
		'practice' => false,
		'botplay' => false,
		'opponentplay' => false
	];

	/**
	 * Should there be a background behind the strumline?
	 */
	public var noteLanes:Bool = false;

	/**
	 * How transparent the note lanes should be.
	 */
	public var noteLaneAlpha:Float = 0.4;

	/**
	 * How much the hit windows will be shifted for each note combo type.
	 */
	public var comboOffset:Array<Int> = [0, 0, 0, 0];

	/**
	 * Changes how late/early you have to hit for a "Sick!" note.
	 * The higher the value, the more time you can hit later. 
	 */
	public var ratingOffset:Int = 0;

	/**
	 * The maximum length from the strumline you can hit a "Sick!" note.
	 */
	public var sickWindow:Int = 45;

	/**
	 * The maximum range you can hit a "Good!" note.
	 * Minimum range starts from the "Sick!" window (`45`).
	 */
	public var goodWindow:Int = 90;

	/**
	 * The maximum range you can hit a "Bad" note.
	 * Minimum range starts from the "Good!" window (`60`).
	 */
	public var badWindow:Int = 135;

	/**
	 * Changes how many frames you have for hitting a note earlier or later.
	 */
	public var safeFrames:Float = 10;

	/**
	 * Should the player get one miss and never hit the note's tail again if the said note's key is let go?
	 */
	public var guitarHeroSustains:Bool = true;

	/**
	 * Should the game display in the user's Discord activity?
	 */
	public var discordRPC:Bool = true;

	/**
	 * Should the game show a cool screen when loading?
	 */
	public var loadingScreen:Bool = true;

	/**
	 * The language that is displayed in-game.
	 */
	public var language:String = 'en-US';

	/**
	 * Should the game minimize it's volume when the window loses focus?  
	 * (***NOTE***: This only works on desktop platforms.)
	 */
	public var minimizeVolume:Bool = true;
}

/**
 * Class that is used for holding, storing and accessing the player's options.
 */
class ClientPrefs
{
	/**
	 * The player's options that are used to access and change in-game.
	 */
	public static var data:SaveVariables = {};

	/**
	 * The default values that are used in case a value is `null`.
	 */
	public static var defaultData:SaveVariables = {};

	/**
	 * Map that stores all of the key binds for the keyboard that are used for gameplay.
	 * The key is the ID for the bind, while the value is the keys you can press.
	 * Note that the maximum amount of keys is two, any values after that will be ignored.
	 * 
	 * When you want to add your own keybinds, add the ID as the key and the keys as the
	 * value (note that you do not always need to have two keys, you can add one or even none!).
	 * After you add it here, add your bind in the `Controls.hx` file (located in the `backend` package), and
	 * the `ControlsSubState.hx` file (located in the `options` package) to make it rebindable.
	 */
	public static var keyBinds:Map<String, Array<FlxKey>> = [
		// Strumline notes
		'note_up'     => [W, UP],
		'note_left'   => [A, LEFT],
		'note_down'   => [S, DOWN],
		'note_right'  => [D, RIGHT],

		// Navigating the UI
		'ui_up'       => [W, UP],
		'ui_left'     => [A, LEFT],
		'ui_down'     => [S, DOWN],
		'ui_right'    => [D, RIGHT],

		// Global controls
		'accept'      => [SPACE, ENTER],
		'back'        => [BACKSPACE, ESCAPE],
		'pause'       => [ENTER, ESCAPE],
		'reset'       => [R],
		'fullscreen'  => [F11],

		// Volume controls
		'volume_mute' => [F12],
		'volume_up'   => [NUMPADPLUS, PLUS],
		'volume_down' => [NUMPADMINUS, MINUS],

		// Debug
		'debug_1'     => [F3],
		'debug_2'     => [F4]
	];

	/**
	 * Map that stores all of the buttons on a controller/gamepad that are used for gameplay.
	 * The key is the ID for the bind, while the value is the buttons you can press.
	 * Note that the maximum amount of buttons is two, any values after that will be ignored.
	 * 
	 * When you want to add your own binds, add the ID as the key and the buttons as the
	 * value (note that you do not always need to have two buttons, you can add one or even none!).
	 * After you add it here, add your bind in the `Controls.hx` file (located in the `backend` package), and
	 * the `ControlsSubState.hx` file (located in the `options` package) to make it rebindable.
	 */
	public static var gamepadBinds:Map<String, Array<FlxGamepadInputID>> = [
		// Strumline notes
		'note_up'    => [DPAD_UP, Y],
		'note_left'  => [DPAD_LEFT, X],
		'note_down'  => [DPAD_DOWN, A],
		'note_right' => [DPAD_RIGHT, B],

		// Navigating the UI
		'ui_up'      => [DPAD_UP, LEFT_STICK_DIGITAL_UP],
		'ui_left'    => [DPAD_LEFT, LEFT_STICK_DIGITAL_LEFT],
		'ui_down'    => [DPAD_DOWN, LEFT_STICK_DIGITAL_DOWN],
		'ui_right'   => [DPAD_RIGHT, LEFT_STICK_DIGITAL_RIGHT],

		// Global controls
		'accept'     => [A, START],
		'back'       => [B],
		'pause'      => [START],
		'reset'      => [BACK]
	];

	/**
	 * Default controls for the keyboard.
	 */
	public static var defaultKeys:Map<String, Array<FlxKey>> = null;

	/**
	 * Default controls for the gamepad.
	 */
	public static var defaultButtons:Map<String, Array<FlxGamepadInputID>> = null;

	/**
	 * Reset all of the key binds to the default values.
	 * - `null` = Both
	 * - `false` = Keyboard
	 * - `true` = Gamepad/controller
	 * @param controller Used to determine what specific kind of keys to reset.
	 */
	public static function resetKeys(controller:Null<Bool> = null):Void
	{
		// If "controller" is false, reset all of the keyboard bindings
		if (controller == false)
			// Loop through each key in the keyboard bindings
			for (key in keyBinds.keys())
				// If the said key exists in the default keys map,
				// set the key to its paired default value
				if (defaultKeys.exists(key))
					keyBinds.set(key, defaultKeys.get(key).copy());

		// If "controller" is true, reset all of the gamepad bindings
		if (controller == true)
			// Loop through each key in the gamepad bindings
			for (button in gamepadBinds.keys())
				// If the said button exists in the default buttons map,
				// set the button to its paired default value
				if (defaultButtons.exists(button))
					gamepadBinds.set(button, defaultButtons.get(button).copy());
	}

	/**
	 * Clear all of the empty, unbinded keys.
	 * @param key The key to be cleared.
	 */
	public static function clearInvalidKeys(key:String)
	{
		// Get the said bind for the keyboard
		var keyBind:Array<FlxKey> = keyBinds.get(key);
		// Get the said bind for the gamepad
		var gamepadBind:Array<FlxGamepadInputID> = gamepadBinds.get(key);
		
		// Loop through all of the binds for the keyboard and
		// remove all of the empty binds
		while (keyBind != null && keyBind.contains(NONE))
			keyBind.remove(NONE);
		// Loop through all of the binds for the gamepad and
		// remove all of the empty binds
		while (gamepadBind != null && gamepadBind.contains(NONE))
			gamepadBind.remove(NONE);
	}

	/**
	 * Sets and loads all of the default keys for ***BOTH*** the keyboard and gamepad.
	 */
	public static function loadDefaultKeys()
	{
		defaultKeys = keyBinds.copy();
		defaultButtons = gamepadBinds.copy();
	}

	/**
	 * Saves all of the settings.
	 */
	public static function saveSettings()
	{
		// Save all of the main settings
		for (key in Reflect.fields(data))
			Reflect.setField(FlxG.save.data, key, Reflect.field(data, key));

		// Save all of the achievements (if they are allowed)
		#if ACHIEVEMENTS_ALLOWED Achievements.save(); #end
		var mainSettingsSaved:Bool = FlxG.save.flush();

		// All of the player's controls are saved in a seperate save bind so that way
		// things like their scores doesn't get deleted
		
		// Create a new save
		var save:FlxSave = new FlxSave();

		// Create a new bind with the said path
		save.bind('controls_v3', CoolUtil.getSavePath());
		// Save the keyboard bindings
		save.data.keyboard = keyBinds;
		// Save the gamepad bindings
		save.data.gamepad = gamepadBinds;
		// Save the keybinds
		var controlsSaved:Bool = save.flush();
		
		// Check and log if the settings saved correctly
		if (mainSettingsSaved && controlsSaved)
			FlxG.log.add("All settings have been saved!");
		else if (mainSettingsSaved && !controlsSaved)
			FlxG.log.add("Main settings were saved, but the controls save failed.");
		else
			FlxG.log.add("Main settings failed to save, but the controls save successfully.");
		
	}

	/**
	 * Get and load all of the player's settings.
	 */
	public static function loadPrefs()
	{
		// Load the achievements the player has earned
		// (if they are allowed)
		#if ACHIEVEMENTS_ALLOWED Achievements.load(); #end

		// Load all of the player's options
		for (key in Reflect.fields(data))
			if (key != 'gameplaySettings' && Reflect.hasField(FlxG.save.data, key))
				Reflect.setField(data, key, Reflect.field(FlxG.save.data, key));

		// Load the visibility for the FPS counter
		if (Main.fpsVar != null)
			Main.fpsVar.visible = data.showFPS;

		// Load the auto pause preference
		#if (!html5 && !switch)
		FlxG.autoPause = ClientPrefs.data.autoPause;

		// Load the framerate preference
		if (FlxG.save.data.framerate == null)
		{
			final refreshRate:Int = FlxG.stage.application.window.displayMode.refreshRate;
			data.framerate = Std.int(FlxMath.bound(refreshRate, 60, 240));
		}
		#end

		// Confirm that the refresh rate and the draw framerate
		// are the same
		if (data.framerate > FlxG.drawFramerate)
		{
			FlxG.updateFramerate = data.framerate;
			FlxG.drawFramerate = data.framerate;
		}
		else
		{
			FlxG.drawFramerate = data.framerate;
			FlxG.updateFramerate = data.framerate;
		}

		// Load all of the gameplay settings
		if (FlxG.save.data.gameplaySettings != null)
		{
			var savedMap:Map<String, Dynamic> = FlxG.save.data.gameplaySettings;
			for (name => value in savedMap)
				data.gameplaySettings.set(name, value);
		}

		// Flixel automatically saves your volume!
		if (FlxG.save.data.volume != null)
			FlxG.sound.volume = FlxG.save.data.volume;
		if (FlxG.save.data.mute != null)
			FlxG.sound.muted = FlxG.save.data.mute;

		#if DISCORD_ALLOWED DiscordClient.check(); #end

		// Load the controls
		var save:FlxSave = new FlxSave();
		save.bind('controls_v3', CoolUtil.getSavePath());
		if (save != null)
		{
			if (save.data.keyboard != null)
			{
				var loadedControls:Map<String, Array<FlxKey>> = save.data.keyboard;
				for (control => keys in loadedControls)
					if (keyBinds.exists(control))
						keyBinds.set(control, keys);
			}
			if (save.data.gamepad != null)
			{
				var loadedControls:Map<String, Array<FlxGamepadInputID>> = save.data.gamepad;
				for (control => keys in loadedControls)
					if (gamepadBinds.exists(control))
						gamepadBinds.set(control, keys);
			}
			reloadVolumeKeys();
		}
	}

	
	/**
	 * Get a specific gameplay setting.
	 * @param name               The ID of the said gameplay setting.
	 * @param defaultValue       The default value to be returned if the said setting isn't found.
	 * @param customDefaultValue If it uses a custom default value.
	 * @return                   The value of the setting. Returns `defaultValue` if it isn't found.
	 */
	inline public static function getGameplaySetting(name:String, defaultValue:Dynamic = null, ?customDefaultValue:Bool = false):Dynamic
	{
		if (!customDefaultValue)
			defaultValue = defaultData.gameplaySettings.get(name);
		return (data.gameplaySettings.exists(name) ? data.gameplaySettings.get(name) : defaultValue);
	}

	/**
	 * Reset the volume keys.
	 */
	public static function reloadVolumeKeys()
	{
		CacheUtil.muteKeys = keyBinds.get('volume_mute').copy();
		CacheUtil.volumeDownKeys = keyBinds.get('volume_down').copy();
		CacheUtil.volumeUpKeys = keyBinds.get('volume_up').copy();
		toggleVolumeKeys(true);
	}

	/**
	 * Toggle the volume keys.
	 * @param turnOn If it should be assigned to an empty array.
	 */
	public static function toggleVolumeKeys(?turnOn:Bool = true)
	{
		final EMPTY_ARRAY = [];
		FlxG.sound.muteKeys = turnOn ? CacheUtil.muteKeys : EMPTY_ARRAY;
		FlxG.sound.volumeDownKeys = turnOn ? CacheUtil.volumeDownKeys : EMPTY_ARRAY;
		FlxG.sound.volumeUpKeys = turnOn ? CacheUtil.volumeUpKeys : EMPTY_ARRAY;
	}
}
