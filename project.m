[wav_data, wav_rate] = audioread('test.wav');
wav_data_size = size(wav_data, 1);

wav_time = zeros(1, wav_data_size);
wav_time_data = wav_time;

for i = 1 : wav_data_size
    wav_time_data(i) = wav_data(i, 1) + wav_data(i, 2);
    wav_time(i) = (i - 1) ./ wav_rate;
end

%drawing time plot
 figure()
 plot(wav_time, wav_time_data)
 set(gca,'color',[0.2,1,0.1])
 title('time plot')
 xlabel('second')
 ylabel('domain')

% calculating furie
half_wav_data_size = floor(wav_data_size / 2);
freq = linspace(0.0, floor(wav_rate / 2), half_wav_data_size);
freq_data = fft(wav_time_data);

% calculating frequency domain data 
abs_real = abs(freq_data(1: half_wav_data_size));
freq_data = 2 / wav_data_size * abs_real;

%drawing frequency plot
 figure()
 plot(freq, freq_data)
 set(gca,'color',[1,1,0.1])
 title('frequency domain 100 to fs/2')
 xlabel('Hertz')
 ylabel('domain')
 
temp_domain = (100 * floor(wav_data_size / wav_rate): half_wav_data_size);
maximum_domain = max(freq_data (temp_domain));

final_freq = -1;
for i = 1 : half_wav_data_size
    if freq_data(i) == maximum_domain
        final_freq = freq(i);
    end
end


notes_data = readtable('notes.csv');
main_note = [];
for i = 2 : size(notes_data, 1)
    if abs(notes_data.Frequency_Hz(i) - final_freq) <= final_freq * .01
        n = notes_data(i, : );
        main_note = n.Note; 
    end
end

fprintf('note frequency: %f \n', final_freq);
fprintf('sample note is:');
disp(main_note);
