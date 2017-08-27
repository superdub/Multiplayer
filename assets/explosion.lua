--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:b6599f12651a51227bd1345ca436020b:157f618793e60f54a24e7f418bf37d57:ff6ed9a539a848dae2d91c7b3e7c2dd2$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {

        {
            -- 1
            x=321,
            y=68,
            width=32,
            height=33,

            sourceX = 44,
            sourceY = 22,
            sourceWidth = 122,
            sourceHeight = 71
        },
        {
            -- 2
            x=263,
            y=68,
            width=56,
            height=37,

            sourceX = 32,
            sourceY = 23,
            sourceWidth = 122,
            sourceHeight = 71
        },
        {
            -- 3
            x=111,
            y=70,
            width=60,
            height=51,

            sourceX = 29,
            sourceY = 11,
            sourceWidth = 122,
            sourceHeight = 71
        },
        {
            -- 4
            x=287,
            y=1,
            width=70,
            height=65,

            sourceX = 24,
            sourceY = 0,
            sourceWidth = 122,
            sourceHeight = 71
        },
        {
            -- 5
            x=183,
            y=48,
            width=78,
            height=67,

            sourceX = 20,
            sourceY = 0,
            sourceWidth = 122,
            sourceHeight = 71
        },
        {
            -- 6
            x=97,
            y=1,
            width=84,
            height=67,

            sourceX = 19,
            sourceY = 0,
            sourceWidth = 122,
            sourceHeight = 71
        },
        {
            -- 7
            x=1,
            y=1,
            width=94,
            height=67,

            sourceX = 16,
            sourceY = 0,
            sourceWidth = 122,
            sourceHeight = 71
        },
        {
            -- 8
            x=183,
            y=1,
            width=102,
            height=45,

            sourceX = 11,
            sourceY = 1,
            sourceWidth = 122,
            sourceHeight = 71
        },
        {
            -- 9
            x=1,
            y=70,
            width=108,
            height=51,

            sourceX = 7,
            sourceY = 4,
            sourceWidth = 122,
            sourceHeight = 71
        },
    },

    sheetContentWidth = 358,
    sheetContentHeight = 122
}

SheetInfo.frameIndex =
{

    ["1"] = 1,
    ["2"] = 2,
    ["3"] = 3,
    ["4"] = 4,
    ["5"] = 5,
    ["6"] = 6,
    ["7"] = 7,
    ["8"] = 8,
    ["9"] = 9,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
