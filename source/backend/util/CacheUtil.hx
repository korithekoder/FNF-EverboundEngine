package backend.util;

import flixel.input.keyboard.FlxKey;

/**
 * Class that holds general, temporary data for pretty much anything.
 * Examples of general temporary data can be things such as if the game is initalized, for example.
 */
class CacheUtil {
    
    /**
     * Has the game been successfully initialized yet?
     */
    public static var isInitialized:Bool = false;

    /**
     * The last volume that the player had set before the game loses focus.
     */
    public static var lastVolumeUsed:Float;

    /**
     * Keys for muting the game's volume.
     */
    public static var muteKeys:Array<FlxKey> = [FlxKey.ZERO];

	/**
	 * Keys for turning ***DOWN*** the volume.
	 */
	public static var volumeDownKeys:Array<FlxKey> = [FlxKey.NUMPADMINUS, FlxKey.MINUS];

	/**
	 * Keys for turning ***UP*** the volume.
	 */
	public static var volumeUpKeys:Array<FlxKey> = [FlxKey.NUMPADPLUS, FlxKey.PLUS];
}
