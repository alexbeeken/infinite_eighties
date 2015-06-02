my_scale = [:c4, :d4, :e4, :g4, :a4]

define :intro_drum_beat do
  use_random_seed 2

  in_thread do
    1.times do
      phrase_length = 4
      sleep_time = 0
      end_loop = false
      use_synth :mod_tri
      until end_loop == true  do
        sleep_time = 0.125 * (1 + (rand_i(8)))
        if sleep_time < phrase_length
          phrase_length = (phrase_length - sleep_time)
          sleep (sleep_time.abs)
        else
          sleep phrase_length
          end_loop = true
        end

        sample :drum_snare_hard
      end
    end
  end
end



define :drum_bass_kick do

  in_thread do
    loop do
      sample :drum_bass_hard
      sleep 0.5
    end
  end
end

define :snare_and_cymbal do

  in_thread do
    loop do
      sample :drum_cymbal_closed
      sleep 0.25
    end
  end

  in_thread do
    loop do
      sample :drum_snare_hard
      sleep 1
    end
  end

end

define :melody1 do |times, seed|

  in_thread do
    times.times do
      use_random_seed seed
      phrase_length = 4
      sleep_time = 0
      end_loop = false
      use_synth :sine
      until end_loop == true  do
        sleep_time = 0.125 * (1 + (rand_i(8)))
        if sleep_time < phrase_length
          phrase_length = (phrase_length - sleep_time)
          sleep (sleep_time.abs)
        else
          sleep phrase_length
          end_loop = true
        end
        play my_scale.sample(), release: 0.7
      end
    end
  end
end

define :melody2 do |times, seed|

  in_thread do
    times.times do
      use_random_seed seed
      phrase_length = 4
      sleep_time = 0
      end_loop = false
      use_synth :mod_tri
      until end_loop == true  do
        sleep_time = 0.125 * (1 + (rand_i(8)))
        if sleep_time < phrase_length
          phrase_length = (phrase_length - sleep_time)
          sleep (sleep_time.abs)
        else
          sleep phrase_length
          end_loop = true
        end

        play my_scale.sample(), release: 0.5
      end
    end
  end
end

define :breakdown do |length, times, seed|
  in_thread do
    times.times do
      use_random_seed seed
      phrase_length = length
      sleep_time = 0
      end_loop = false
      use_synth :mod_tri
      until end_loop == true  do
        sleep_time = 0.125 * (1 + (rand_i(8)))
        if sleep_time < phrase_length
          phrase_length = (phrase_length - sleep_time)
          sleep (sleep_time.abs)
        else
          sleep phrase_length
          end_loop = true
        end

        play my_scale.sample(), release: 0.5
        sample :drum_bass_hard
        sample :drum_snare_hard
        sample :drum_cymbal_hard
      end
    end
  end
end

forever = true
drum_bass_kick

while forever

intro_drum_beat

sleep 4

snare_and_cymbal
use_random_seed 2

4.times do
  melody1(4, rand_i(20000))
  melody2(4, rand_i(20000))
  sleep 16
end

breakdown(4, 4 , 1)
sleep 16

4.times do
  melody1(4, rand_i(20000))
  melody2(4, rand_i(20000))
  sleep 16
end

end
