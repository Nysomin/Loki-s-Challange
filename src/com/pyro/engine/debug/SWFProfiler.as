/*      
 __       _____   ____    ______      ______   __  __     
/\ \     /\  __`\/\  _`\ /\__  _\    /\__  _\ /\ \/\ \    
\ \ \    \ \ \/\ \ \,\L\_\/_/\ \/    \/_/\ \/ \ \ `\\ \   
 \ \ \  __\ \ \ \ \/_\__ \  \ \ \       \ \ \  \ \ , ` \  
  \ \ \L\ \\ \ \_\ \/\ \L\ \ \ \ \       \_\ \__\ \ \`\ \ 
   \ \____/ \ \_____\ `\____\ \ \_\      /\_____\\ \_\ \_\
    \/___/   \/_____/\/_____/  \/_/      \/_____/ \/_/\/_/
                                                                  
                                                                  
 ______  ____    ______  ______   _____   __  __  ____    ____     ____    ______   ____    ______   
/\  _  \/\  _`\ /\__  _\/\__  _\ /\  __`\/\ \/\ \/\  _`\ /\  _`\  /\  _`\ /\__  _\ /\  _`\ /\__  _\  
\ \ \L\ \ \ \/\_\/_/\ \/\/_/\ \/ \ \ \/\ \ \ `\\ \ \,\L\_\ \ \/\_\\ \ \L\ \/_/\ \/ \ \ \L\ \/_/\ \/  
 \ \  __ \ \ \/_/_ \ \ \   \ \ \  \ \ \ \ \ \ , ` \/_\__ \\ \ \/_/_\ \ ,  /  \ \ \  \ \ ,__/  \ \ \  
  \ \ \/\ \ \ \L\ \ \ \ \   \_\ \__\ \ \_\ \ \ \`\ \/\ \L\ \ \ \L\ \\ \ \\ \  \_\ \__\ \ \/    \ \ \ 
   \ \_\ \_\ \____/  \ \_\  /\_____\\ \_____\ \_\ \_\ `\____\ \____/ \ \_\ \_\/\_____\\ \_\     \ \_\
    \/_/\/_/\/___/    \/_/  \/_____/ \/_____/\/_/\/_/\/_____/\/___/   \/_/\/ /\/_____/ \/_/      \/_/

    
Copyright (c) 2008 Lost In Actionscript - Shane McCartney

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

 */

package com.pyro.engine.debug {
        import flash.display.*;
        import flash.events.*;
        import flash.net.LocalConnection;
        import flash.system.System;
        import flash.ui.*;
        import flash.utils.getTimer;    

        public class SWFProfiler {
                private static var itvTime : int;
                private static var initTime : int;
                private static var currentTime : int;
                private static var frameCount : int;
                private static var totalCount : int;

                public static var minFps : Number;
                public static var maxFps : Number;
                public static var minMem : Number;
                public static var maxMem : Number;
                public static var history : int = 60;
                public static var refreshRate : Number = 1;
                public static var fpsList : Array = [];
                public static var memList : Array = [];

                private static var displayed : Boolean = false;
                private static var started : Boolean = false;
                private static var inited : Boolean = false;
                private static var frame : Sprite;
                private static var stage : Stage;
                private static var content : ProfilerContent;
                private static var ci : ContextMenuItem;

                public static function init(swf : Stage, context : InteractiveObject) : void {
                        if(inited) return;
                        
                        inited = true;
                        stage = swf;
                        
                        content = new ProfilerContent();
                        frame = new Sprite();
                        
                        minFps = Number.MAX_VALUE;
                        maxFps = Number.MIN_VALUE;
                        minMem = Number.MAX_VALUE;
                        maxMem = Number.MIN_VALUE;
                        
                        var cm : ContextMenu = new ContextMenu();
                        cm.hideBuiltInItems();
                        ci = new ContextMenuItem("Show Profiler", true);
                        cm.customItems = [ci];
                        context.contextMenu = cm;
                        addEvent(ci, ContextMenuEvent.MENU_ITEM_SELECT, onSelect);
                        
                        start();
                }

                public static function start() : void {
                        if(started) return;
                        started = true;
                        initTime = itvTime = getTimer();
                        totalCount = frameCount = 0;
                        addEvent(frame, Event.ENTER_FRAME, draw);
                }

                public static function stop() : void {
                        if(!started) return;
                        started = false;
                        removeEvent(frame, Event.ENTER_FRAME, draw);
                }

                public static function gc() : void {
                        try {
                                new LocalConnection().connect('foo');
                                new LocalConnection().connect('foo');
                        } catch (e : Error) {
                        }
                }

                public static function get currentFps() : Number {
                        return frameCount / intervalTime;
                }

                public static function get currentMem() : Number {
                        return (System.totalMemory / 1024) / 1000;
                }

                public static function get averageFps() : Number {
                        return totalCount / runningTime;
                }

                private static function get runningTime() : Number {
                        return (currentTime - initTime) / 1000;
                }

                private static function get intervalTime() : Number {
                        return (currentTime - itvTime) / 1000;
                }

                
                private static function onSelect(e : ContextMenuEvent) : void {
                        if(!displayed) {
                                show();
                        } else {
                                hide();
                        }
                }

                public static function show() : void {
                        ci.caption = "Hide Profiler";
                        displayed = true;
                        stage.addChild(content);
                        updateDisplay();
                }

                public static function hide() : void {
                        ci.caption = "Show Profiler";
                        displayed = false;
                        stage.removeChild(content);
                }

                private static function draw(e : Event = null) : void {
                        currentTime = getTimer();
                        
                        frameCount++;
                        totalCount++;
                        
                        if(intervalTime >= refreshRate) {
                                if(displayed) {
                                        updateDisplay();
                                } else {
                                        updateMinMax();
                                }
                                
                                fpsList.unshift(currentFps);
                                memList.unshift(currentMem);
                                
                                if(fpsList.length > history) fpsList.pop();
                                if(memList.length > history) memList.pop();
                                
                                itvTime = currentTime;
                                frameCount = 0;
                        }
                }

                private static function updateDisplay() : void {
                        updateMinMax();
                        content.update(runningTime, minFps, maxFps, minMem, maxMem, currentFps, currentMem, averageFps, fpsList, memList, history);
                }

                private static function updateMinMax() : void {
                        if(!(currentFps > 0)) return;
                        
                        minFps = Math.min(currentFps, minFps);
                        maxFps = Math.max(currentFps, maxFps);
                                
                        minMem = Math.min(currentMem, minMem);
                        maxMem = Math.max(currentMem, maxMem);
                }

                private static function addEvent(item : EventDispatcher, type : String, listener : Function) : void {
                        item.addEventListener(type, listener, false, 0, true);
                }

                private static function removeEvent(item : EventDispatcher, type : String, listener : Function) : void {
                        item.removeEventListener(type, listener);
                }
        }
}

import flash.display.*;
import flash.events.Event;
import flash.text.*;

internal class ProfilerContent extends Sprite {

        private var minFpsTxtBx : TextField;
        private var maxFpsTxtBx : TextField;
        private var minMemTxtBx : TextField;
        private var maxMemTxtBx : TextField;
        private var infoTxtBx : TextField;
        private var box : Shape;
        private var fps : Shape;
        private var mb : Shape;

        public function ProfilerContent() : void {
                fps = new Shape();
                mb = new Shape();
                box = new Shape();
                        
                this.mouseChildren = false;
                this.mouseEnabled = false;
                        
                fps.x = 65;
                fps.y = 45;     
                mb.x = 65;
                mb.y = 90;
                        
                var tf : TextFormat = new TextFormat("_sans", 9, 0xAAAAAA);
                        
                infoTxtBx = new TextField();
                infoTxtBx.autoSize = TextFieldAutoSize.LEFT;
                infoTxtBx.defaultTextFormat = new TextFormat("_sans", 11, 0xCCCCCC);
                infoTxtBx.y = 98;
                        
                minFpsTxtBx = new TextField();
                minFpsTxtBx.autoSize = TextFieldAutoSize.LEFT;
                minFpsTxtBx.defaultTextFormat = tf;
                minFpsTxtBx.x = 7;
                minFpsTxtBx.y = 37;
                        
                maxFpsTxtBx = new TextField();
                maxFpsTxtBx.autoSize = TextFieldAutoSize.LEFT;
                maxFpsTxtBx.defaultTextFormat = tf;
                maxFpsTxtBx.x = 7;
                maxFpsTxtBx.y = 5;
                        
                minMemTxtBx = new TextField();
                minMemTxtBx.autoSize = TextFieldAutoSize.LEFT;
                minMemTxtBx.defaultTextFormat = tf;
                minMemTxtBx.x = 7;
                minMemTxtBx.y = 83;
                        
                maxMemTxtBx = new TextField();
                maxMemTxtBx.autoSize = TextFieldAutoSize.LEFT;
                maxMemTxtBx.defaultTextFormat = tf;
                maxMemTxtBx.x = 7;
                maxMemTxtBx.y = 50;
                        
                addChild(box);
                addChild(infoTxtBx);
                addChild(minFpsTxtBx);
                addChild(maxFpsTxtBx);
                addChild(minMemTxtBx);
                addChild(maxMemTxtBx);
                addChild(fps);
                addChild(mb);
                
                this.addEventListener(Event.ADDED_TO_STAGE, added, false, 0, true);
                this.addEventListener(Event.REMOVED_FROM_STAGE, removed, false, 0, true);
        }

        public function update(runningTime : Number, minFps : Number, maxFps : Number, minMem : Number, maxMem : Number, currentFps : Number, currentMem : Number, averageFps : Number, fpsList : Array, memList : Array, history : int) : void {
                if(runningTime >= 1) {
                        minFpsTxtBx.text = minFps.toFixed(3) + " Fps";
                        maxFpsTxtBx.text = maxFps.toFixed(3) + " Fps";
                        minMemTxtBx.text = minMem.toFixed(3) + " Mb";
                        maxMemTxtBx.text = maxMem.toFixed(3) + " Mb";
                }
                        
                infoTxtBx.text = "Current Fps " + currentFps.toFixed(3) + "   |   Average Fps " + averageFps.toFixed(3) + "   |   Memory Used " + currentMem.toFixed(3) + " Mb";
                infoTxtBx.x = stage.stageWidth - infoTxtBx.width - 20;
                
                var vec : Graphics = fps.graphics;
                vec.clear();
                vec.lineStyle(1, 0x33FF00, 0.7);
                        
                var i : int = 0;
                var len : int = fpsList.length;
                var height : int = 35;
                var width : int = stage.stageWidth - 80;
                var inc : Number = width / (history - 1);
                var rateRange : Number = maxFps - minFps;
                var value : Number;
                        
                for(i = 0;i < len; i++) {
                        value = (fpsList[i] - minFps) / rateRange;
                        if(i == 0) {
                                vec.moveTo(0, -value * height);
                        } else {
                                vec.lineTo(i * inc, -value * height);
                        }
                }
                        
                vec = mb.graphics;
                vec.clear();
                vec.lineStyle(1, 0x0066FF, 0.7);
                        
                i = 0;
                len = memList.length;
                rateRange = maxMem - minMem;
                for(i = 0;i < len; i++) {
                        value = (memList[i] - minMem) / rateRange;
                        if(i == 0) {
                                vec.moveTo(0, -value * height);
                        } else {
                                vec.lineTo(i * inc, -value * height);
                        }
                }
        }

        private function added(e : Event) : void {
                resize();
                stage.addEventListener(Event.RESIZE, resize, false, 0, true);
        }

        private function removed(e : Event) : void {
                stage.removeEventListener(Event.RESIZE, resize);
        }

        private function resize(e : Event = null) : void {
                var vec : Graphics = box.graphics;
                vec.clear();
                
                vec.beginFill(0x000000, 0.9);
                vec.drawRect(0, 0, stage.stageWidth, 120);
                vec.lineStyle(1, 0xFFFFFF, 0.2);
                        
                vec.moveTo(65, 45);
                vec.lineTo(65, 10);
                vec.moveTo(65, 45);
                vec.lineTo(stage.stageWidth - 15, 45);
                        
                vec.moveTo(65, 90);
                vec.lineTo(65, 55);
                vec.moveTo(65, 90);
                vec.lineTo(stage.stageWidth - 15, 90);
                        
                vec.endFill();
                
                infoTxtBx.x = stage.stageWidth - infoTxtBx.width - 20;
        }
}