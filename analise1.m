clear
file = "EV_2019.1_3";
Time = 1;
Sats = 4;
HPL = 5;
VPL = 6;
HPL_Ref = 16;
VPL_Ref = 5;
Lat = 7;
Lon = 8;
Alt = 9;
Ref = 6;
ER = 6.371*10^6;
deg = pi/180;
Hor = 1;
Ver = 2;
HAL_Ref = 40;
VAL_Ref = 12; % CAT-I

fp = fopen(file,'r');
m = data_read(fp);
fclose(fp);

errors = zeros(2, size_lin(m));
alerts = zeros(2, size_lin(m));

for i = 1:size_lin(m)
    dLat = abs(ER*deg*(m(i, Lat) - m(i, Lat+Ref)));
    dLon = abs(ER*deg*(m(i, Lon) - m(i, Lon+Ref)));
    
    errors(Hor, i) = sqrt(dLat^2 + dLon^2);
    errors(Ver, i) = abs(m(i, Alt) - m(i, Alt+Ref));
    
    alerts(Hor, i) = errors(Hor, i) - m(i, HPL);
    if alerts(Hor, i) > 0
       disp("poop horizontal");
       disp(i);
    end
    alerts(Ver, i) = errors(Ver, i) - m(i, VPL);
    if alerts(Ver, i) > 0
       disp("poop vertical");
       disp(i);
    end
end

HNE = prctile(errors(Hor), 95);
VNE = prctile(errors(Ver), 95);

HAL = prctile(abs(alerts(Hor)), 99);
VAL = prctile(abs(alerts(Ver)), 99);

Dispo = 1;

for i = 1:size_lin(m)
    if (HAL_Ref-m(i,HPL) < 0) || (VAL_Ref-m(i,VPL) < 0)
        Dispo = Dispo - (1/size_lin(m));
    end
end

HPL_Vec = HPL_Ref*ones(1, size_lin(m));
VPL_VEC = HPL_Ref*ones(1, size_lin(m));

plot(m(i,Time), HPL_Vec);




% função para ler os valores dos ficheiros
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

%função auxiliar para tamanho do vetor
function n = size_col(v)
    [~, n] = size(v);
end

function n = size_lin(v)
    [n, ~] = size(v);
end