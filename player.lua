local dfpwm = require("cc.audio.dfpwm")
--local speaker_left = peripheral.wrap("left")
--local speaker_right = peripheral.wrap("left")
local speakers = { peripheral.find("speaker") }
local leftFound = false
local speaker_left, speaker_right
for _, speaker in pairs(speakers) do
  if leftFound then
    speaker_right = speaker
  end
  if peripheral.getName(speaker) == "speaker_1561" then
    leftFound = true
    speaker_left = speaker
  else
    speaker_right = speaker
  end
end

local decoder = dfpwm.make_decoder()
--[[ local function left()
for chunk in io.lines("./disk/left.dfpwm", 16 * 1024) do
    local buffer = decoder(chunk)
    while not speaker_left.playAudio(buffer) do
        os.pullEvent("speaker_audio_empty")
    end
end
end
local function right()
for chunk in io.lines("./disk2/right.dfpwm", 16 * 1024) do
    local buffer = decoder(chunk)
    while not speaker_right.playAudio(buffer) do
        os.pullEvent("speaker_audio_empty")
    end
end
end ]]--

-- read the file and play it
local i = 1
while true do
  io.open("./disk/left.dfpwm")
  local buffer_left = decoder(io.read(i*1024))
  io.close()
  io.open("./disk2/right/dfpwm")
  local buffer_right = decoder(io.read(i*1024))
  io.close()
  speaker_left.playAudio(buffer_left)
  while not speaker_right.playAudio(buffer_right) do
        os.pullEvent("speaker_audio_empty")
  end
  i = i + 1
end


--parallel.waitForAll(left, right)
