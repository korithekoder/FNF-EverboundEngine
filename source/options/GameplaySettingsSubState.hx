package options;

class GameplaySettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = Language.getPhrase('gameplay_menu', 'Gameplay Settings');
		rpcTitle = 'Gameplay Settings Menu'; // For Discord rich presence

		var option:Option = new Option(
			'Downscroll',
			'When checked, notes go down instead of up, simple enough.',
			'downScroll',
			BOOL
		);
		addOption(option);

		var option:Option = new Option(
			'Middlescroll',
			'When checked, your notes get centered.',
			'middleScroll',
			BOOL
		);
		addOption(option);

		var option:Option = new Option(
			'Opponent Notes',
			'When unchecked, opponent notes get hidden.',
			'opponentStrums',
			BOOL
		);
		addOption(option);

		var option:Option = new Option(
			'Ghost Tapping',
			"When checked, you won't get misses from pressing keys\nwhile there are no notes able to be hit.",
			'ghostTapping',
			BOOL
		);
		addOption(option);
		
		#if !html5
		var option:Option = new Option(
			'Auto Pause',
			"When checked, the game automatically pauses if the screen isn't on focus.",
			'autoPause',
			BOOL
		);
		addOption(option);
		option.onChange = onChangeAutoPause;
		#end

		var option:Option = new Option(
			'Disable Reset Button',
			"When checked, pressing Reset won't do anything.",
			'noReset',
			BOOL
		);
		addOption(option);

		var option:Option = new Option(
			'Hitsound Volume',
			'Funny notes does \"Tick!\" when you hit them.',
			'hitsoundVolume',
			PERCENT
		);
		addOption(option);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		option.onChange = onChangeHitsoundVolume;

		var option:Option = new Option(
			'Rating Offset',
			'Changes the position of the strumline starting from the middle.\n"0" is dead center.',
			'ratingOffset',
			INT
		);
		option.displayFormat = '%vms';
		option.scrollSpeed = 20;
		option.minValue = -30;
		option.maxValue = 30;
		addOption(option);

		var option:Option = new Option(
			'Sick! Hit Window',
			'Changes the amount of time you have\nfor hitting a "Sick!" in milliseconds.',
			'sickWindow',
			INT
		);
		option.displayFormat = '%vms';
		option.scrollSpeed = 15;
		option.minValue = 15;
		option.maxValue = 45;
		addOption(option);

		var option:Option = new Option(
			'Good Hit Window',
			'Changes the amount of time you have\nfor hitting a "Good" in milliseconds.',
			'goodWindow',
			INT
		);
		option.displayFormat = '%vms';
		option.scrollSpeed = 30;
		option.minValue = 15;
		option.maxValue = 90;
		addOption(option);

		var option:Option = new Option(
			'Bad Hit Window',
			'Changes the amount of time you have\nfor hitting a "Bad" in milliseconds.',
			'badWindow',
			INT
		);
		option.displayFormat = '%vms';
		option.scrollSpeed = 60;
		option.minValue = 15;
		option.maxValue = 135;
		addOption(option);

		var option:Option = new Option(
			'Safe Frames',
			'Changes how many frames you have for\nhitting a note earlier or late.',
			'safeFrames',
			FLOAT
		);
		option.scrollSpeed = 5;
		option.minValue = 2;
		option.maxValue = 10;
		option.changeValue = 0.1;
		addOption(option);

		var option:Option = new Option(
			'Sustains as One Note',
			"When checked, Hold Notes can't be pressed if you miss,\nand count as a single Hit/Miss.\nUncheck this if you prefer the old input system.",
			'guitarHeroSustains',
			BOOL
		);
		addOption(option);

		#if desktop
		var option:Option = new Option(
			'Minimize Volume on Lost Focus',
			"Minimizes the game's volume when the window loses focus.",
			'minimizeVolume',
			BOOL
		);
		addOption(option);
		#end

		super();
	}

	function onChangeHitsoundVolume()
		FlxG.sound.play(PathsUtil.sound('hitsound'), ClientPrefs.data.hitsoundVolume);

	function onChangeAutoPause()
		FlxG.autoPause = ClientPrefs.data.autoPause;
}
