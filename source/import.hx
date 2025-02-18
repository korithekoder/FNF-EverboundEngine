#if !macro
//Discord API
#if DISCORD_ALLOWED
import backend.api.DiscordClient;
#end

//Psych
#if LUA_ALLOWED
import llua.*;
import llua.Lua;
#end

#if ACHIEVEMENTS_ALLOWED
import backend.gameplay.Achievements;
#end

#if sys
import sys.*;
import sys.io.*;
#elseif js
import js.html.*;
#end

import backend.util.PathsUtil;
import backend.data.Controls;
import backend.util.CoolUtil;
import backend.display.MusicBeatState;
import backend.display.MusicBeatSubstate;
import backend.display.CustomFadeTransition;
import backend.data.ClientPrefs;
import backend.gameplay.Conductor;
import backend.display.BaseStage;
import backend.gameplay.Difficulty;
import backend.data.Mods;
import backend.data.Language;

import backend.ui.*; // Psych-UI

import objects.Alphabet;
import objects.BGSprite;

import states.PlayState;
import states.LoadingState;

#if flxanimate
import flxanimate.*;
import flxanimate.PsychFlxAnimate as FlxAnimate;
#end

// Flixel
import flixel.sound.FlxSound;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.transition.FlxTransitionableState;

using StringTools;
#end
