clear
file = "EV_2019.3_3";
fp = fopen(file,'r');
m = data_read(fp);
fclose(fp);

Time = 1;
A1 = 2;
A2 = 3;
A3 = 4;
A4 = 5;


time = m(:,Time);
a1 = m(:,A1);
a2 = m(:,A2);
a3 = m(:,A3);
a4 = m(:,A4);

% representar graficamente a variacao temporal das grandezas medidas
figure();

subplot(2,2,1);
plot(time, a1);
xlabel('t (s)');
ylabel('a1 (m/s^2) ');

subplot(2,2,2);
plot(time, a2);
xlabel('t (s)');
ylabel('a2 (m/s^2) ');

subplot(2,2,3);
plot(time, a3);
xlabel('t (s)');
ylabel('a3 (m/s^2) ');

subplot(2,2,4);
plot(time, a4);
xlabel('t (s)');
ylabel('a4 (m/s^2) ');

suptitle('representacao temporal das aceleracoes');


T = 0.004;
Fs = 1/T;
L = size_lin(m);
NFFT = 2^(nextpow2(L));
ff = Fs/2*linspace(0,1,NFFT/2+1);

figure();

subplot(2,2,1);
dsms1 = fft(a1,NFFT)/L;
ssms1 = 2*abs(dsms1(1:(NFFT/2+1)));
plot(ff, ssms1);
xlabel('f (Hz)');
ylabel('|a1| (m/s^2)');
%picos em 1,007/5,266 2,991/3,04 10,01/2,8 19,99/0,9311

subplot(2,2,2);
dsms2 = fft(a2,NFFT)/L;
ssms2 = 2*abs(dsms2(1:(NFFT/2+1)));
plot(ff, ssms2);
xlabel('f (Hz)');
ylabel('|a2| (m/s^2)');
%pico em 3,998/3,725

subplot(2,2,3);
dsms3 = fft(a3,NFFT)/L;
ssms3 = 2*abs(dsms3(1:(NFFT/2+1)));
plot(ff, ssms3);
xlabel('f (Hz)');
ylabel('|a3| (m/s^2)');
%pico em 2,014/5,437 3,998/3,717

subplot(2,2,4);
dsms4 = fft(a4,NFFT)/L;
ssms4 = 2*abs(dsms4(1:(NFFT/2+1)));
plot(ff, ssms4);
xlabel('f (Hz)');
ylabel('|a4| (m/s^2)');
%pico em 2,014/5,445

suptitle('espetro unilateral de amplitude de cada aceleracao');

%utilizar a funcao data cursor para determinar os maximos 



% funcao para ler os valores dos ficheiros
function mat = data_read(fp)
    cols = 1;
    line = fgets(fp);
    mat = 0;
    
    for i = 1:size_col(line)
        if line(i) == ';'
            cols = cols + 1;
        end
    end
    
    while ~feof(fp)
        line = fgets(fp);
        aux = sscanf(line, "%f;", [1, cols]);
        if mat == 0
            mat = aux;
        else
            mat = [mat; aux];
        end
    end

end

%funcoes auxiliares para tamanho da matriz
function n = size_col(v)
    [~, n] = size(v);
end

function n = size_lin(v)
    [n, ~] = size(v);
end
