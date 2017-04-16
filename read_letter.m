function letter=read_letter(imagn,num_letras)
% Computes the correlation between template and input image
% and its output is a string containing the letter.
% Size of 'imagn' must be 42 x 24 pixels
% Example:
% imagn=imread('D.bmp');
% letter=read_letter(imagn)
global templates
global numero
comp=[ ];
for n=1:num_letras
    sem=corr2(templates{1,n},imagn);
    comp=[comp sem];
end
vd=find(comp==max(comp));
%*-*-*-*-*-*-*-*-*-*-*-*-*-
if vd==1
    letter='A';
     
elseif vd==2
    letter='B';
    numero= 2;
elseif vd==3
    letter='C';
elseif vd==4
    letter='D';
elseif vd==5
    letter='E';
elseif vd==6
    letter='F';
elseif vd==7
    letter='G';
elseif vd==8
    letter='H';
elseif vd==9
    letter='I';
elseif vd==10
    letter='J';
elseif vd==11
    letter='K';
elseif vd==12
    letter='L';
elseif vd==13
    letter='M';
elseif vd==14
    letter='N';
elseif vd==15
    letter='O';
elseif vd==16
    letter='P';
elseif vd==17
    letter='Q';
elseif vd==18
    letter='R';
elseif vd==19
    letter='S';
elseif vd==20
    letter='T';
elseif vd==21
    letter='U';
elseif vd==22
    letter='V';
elseif vd==23
    letter='W';
elseif vd==24
    letter='X';
elseif vd==25
    letter='Y';
elseif vd==26
    letter='Z';
    %*-*-*-*-*
elseif vd==27
    letter='1';
    [s Fs]=wavread('uno.wav');
    wavplay(s,Fs);
    fprintf('1\n'); 
elseif vd==28
    letter='2'; 
    [s Fs]=wavread('dos.wav');
    wavplay(s,Fs);
     fprintf('2\n');
     
elseif vd==29
    letter='3';
    [s Fs]=wavread('tres.wav');
    wavplay(s,Fs);
     fprintf('3\n');
     
elseif vd==30
    letter='4';
    [s Fs]=wavread('cuatro.wav');
    wavplay(s,Fs);
     fprintf('4\n');
elseif vd==31
    letter='5';
     fprintf('5\n');
     [s Fs]=wavread('cinco.wav');
    wavplay(s,Fs);
     
elseif vd==32
    letter='6';
    [s Fs]=wavread('seis.wav');
    wavplay(s,Fs);
     fprintf('6\n');
elseif vd==33
    letter='7';
     fprintf('7\n');
     [s Fs]=wavread('siete.wav');
    wavplay(s,Fs);
elseif vd==34
    letter='8';
    [s Fs]=wavread('ocho.wav');
    wavplay(s,Fs);
     fprintf('8\n');
elseif vd==35
    letter='9';
    [s Fs]=wavread('nueve.wav');
    wavplay(s,Fs);
     fprintf('9\n');
     
else 
    letter='0';
     fprintf('0\n');

end

