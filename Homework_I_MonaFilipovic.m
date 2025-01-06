try

% Open black Window 
myWindow = Screen('OpenWindow', 0, [0 0 0]);

[screenx, screeny] = Screen('WindowSize', myWindow);
baseRect = [0 0 400 500]; 
centeredRect = CenterRectOnPoint(baseRect, screenx/2, screeny/2);

%Zugriff auf Bilder
folder =  fullfile(pwd, 'Faces_MonaFilipovic');
imgdata = dir(fullfile(folder, '*.jpg'));

%Random
randomorder = randperm(length(imgdata));

for i = 1:15
%Fadenkreuz
Screen('TextSize', myWindow, 25);
DrawFormattedText(myWindow, '+', 'center', 'center', [250 250 250]);
Screen('Flip', myWindow);
WaitSecs(3.0);

%jittered time zwischen 0.5 und 1.5 Sekunden
jitter = randi([5 15], 1, 1)/10;

% Mask/Noise
randommask = rand(400, 400) * 255;
masktexture = uint8(randommask);
mymask = Screen('MakeTexture', myWindow, masktexture);
Screen('DrawTexture', myWindow, mymask, [], centeredRect);
Screen('Flip', myWindow);
WaitSecs(jitter);


%Zufälliges Bild
%zufälliger Index für die gelesenen Dateien
path = fullfile(folder, imgdata(randomorder(i)).name);

try
    presentrandomface = imread(path);
    %Zeichnet das Bild
    myTexture = Screen('MakeTexture', myWindow, presentrandomface);
    Screen('DrawTexture', myWindow, myTexture, [], centeredRect);
    %Präsentiert
    Screen('Flip', myWindow);
    WaitSecs(0.1)
    Screen('Close', myTexture);
    Screen('Flip', myWindow);

%Famous/Non-Famous Frage
Screen('TextSize', myWindow, 25);
DrawFormattedText(myWindow, 'Famous \n ↑  \n  ↓ \n Non-Famous' , 'center', 'center', [250 250 250]);
Screen('Flip', myWindow);
KbWait;
Screen ('Flip', myWindow);
catch
    continue; 
end

end 

KbWait;
Screen('CloseAll');  

catch
    Screen('CloseAll');
    psychrethrow(psychlasterror);
end
