close all
clear all
clc
%% raid�i� pavyzd�i� nuskaitymas ir po�ymi� skai�iavimas
%% read the image with hand-written characters
pavadinimas = 'mokymas5.png';
pozymiai_tinklo_mokymui = pozymiai_raidems_atpazinti(pavadinimas, 4);
%% Atpa�intuvo k�rimas
%% Development of character recognizer
% po�ymiai i� celi� masyvo perkeliami � matric�
% take the features from cell-type variable and save into a matrix-type variable
P = cell2mat(pozymiai_tinklo_mokymui);
% sukuriama teising� atsakym� matrica: 11 raid�i�, 8 eilut�s mokymui
% create the matrices of correct answers for each line (number of matrices = number of symbol lines)
T = [eye(5), eye(5), eye(5), eye(5)];
% sukuriamas SBF tinklas duotiems P ir T s�ry�iams
% create an RBF network for classification with 13 neurons, and sigma = 1
tinklas = newrb(P,T,0,1,13);

%% Tinklo patikra | Test of the network (recognizer)
% skai�iuojamas tinklo i��jimas ne�inomiems po�ymiams
% estimate output of the network for unknown symbols (row, that were not used during training)
P2 = P(:,6:10);
Y2 = sim(tinklas, P2);
% ie�koma, kuriame i��jime gauta did�iausia reik�m�
% find which neural network output gives maximum value
[a2, b2] = max(Y2);
%% Rezultato atvaizdavimas
%% Visualize result
% apskai�iuosime raid�i� skai�i� - po�ymi� P2 stulpeli� skai�i�
% calculate the total number of symbols in the row
raidziu_sk = size(P2,2);
% rezultat� saugosime kintamajame 'atsakymas'
% we will save the result in variable 'atsakymas'
atsakymas = [];
for k = 1:raidziu_sk
    switch b2(k)
        case 1
            % the symbol here should be the same as written first symbol in your image
            atsakymas = [atsakymas, 'R'];
        case 2
            atsakymas = [atsakymas, 'A'];
        case 3
            atsakymas = [atsakymas, 'G'];
        case 4
            atsakymas = [atsakymas, 'S'];
        case 5
            atsakymas = [atsakymas, 'E'];
    end
end
% pateikime rezultat� komandiniame lange
% show the result in command window
disp(atsakymas)
% % figure(7), text(0.1,0.5,atsakymas,'FontSize',38)
%% Extract features of the test image
pavadinimas = 'testavimas3.png';
pozymiai_patikrai = pozymiai_raidems_atpazinti(pavadinimas, 1);

%% Raid�i� atpa�inimas
%% Perform letter/symbol recognition
% po�ymiai i� celi� masyvo perkeliami � matric�
% features from cell-variable are stored to matrix-variable
P2 = cell2mat(pozymiai_patikrai);
% skai�iuojamas tinklo i��jimas ne�inomiems po�ymiams
% estimating neuran network output for newly estimated features
Y2 = sim(tinklas, P2);
% ie�koma, kuriame i��jime gauta did�iausia reik�m�
% searching which output gives maximum value
[a2, b2] = max(Y2);
%% Rezultato atvaizdavimas | Visualization of result
% apskai�iuosime raid�i� skai�i� - po�ymi� P2 stulpeli� skai�i�
% calculating number of symbols - number of columns
raidziu_sk = size(P2,2);
% rezultat� saugosime kintamajame 'atsakymas'
atsakymas = [];
for k = 1:raidziu_sk
    switch b2(k)
        case 1
            % the symbol here should be the same as written first symbol in your image
            atsakymas = [atsakymas, 'R'];
        case 2
            atsakymas = [atsakymas, 'A'];
        case 3
            atsakymas = [atsakymas, 'G'];
        case 4
            atsakymas = [atsakymas, 'S'];
        case 5
            atsakymas = [atsakymas, 'E'];
    end
end
% pateikime rezultat� komandiniame lange
% disp(atsakymas)
figure(8), text(0.1,0.5,atsakymas,'FontSize',38), axis off