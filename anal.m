fileS = ["EV_2019.1_3"; "EV_2019.2_3"; "EV_2019.3_3"];

for i = 1:3
    fp = fopen(fileS(i),'r');
    disp(fileS(i));
    line = fgets(fp);
    disp(line);
end






function [mat, l, c] = data_read(~)



end