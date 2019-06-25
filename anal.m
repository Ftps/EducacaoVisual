fileS = ["EV_2019.1_3"; "EV_2019.2_3"; "EV_2019.3_3"];

for i = 1:3
    fp = fopen(fileS(i),'r');
    m = data_read(fp);
    output = choose_func(m, i);
    fclose(fp);
end



% função para ler os valores dos ficheiros
function mat = data_read(fp)
    cols = 1;
    line = fgets(fp);
    mat = 0;
    
    for i = 1:size_vec(line)
        if line(i) == ';'
            cols = cols + 1;
        end
    end
    
    while ~feof(fp)
        line = fgets(fp);
        for i = 1:size_vec(line)
            if line(i) == ';'
                line(i) = ' ';
            end
        end
        aux = sscanf(line, "%f", [1, cols]);
        if mat == 0
            mat = aux;
        else
            mat = [mat; aux];
        end
    end

end

%função que escolhe de que forma analisar os dados
function output = choose_func(m, i)
    switch(i)
        case 1
            output = ev1(m);
        case 2
            output = ev2(m);
        case 3
            output = ev3(m);
        otherwise
            disp("what the hell are you feeding me");
            exit();
    end
end

%função auxiliar para tamanho do vetor
function n = size_vec(v)
    [~, n] = size(v);
end





% ESCREVER CÓDIGO DE ANÁLISE DE CADA PARTE NAS FUNÇÕES ABAIXO:
% FICHEIRO 1 - ev1()
% FICHEIRO 2 - ev2()
% FICHEIRO 3 - ev3()

function out = ev1(m)
    out = 1;
end

function out = ev2(m)
    out = 2;
end

function out = ev3(m)
    out = 3;
end