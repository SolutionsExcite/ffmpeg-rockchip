fate-acodec-%: CODEC = $(@:fate-acodec-%=%)
fate-acodec-%: SRC = tests/data/asynth-44100-2.wav
fate-acodec-%: CMD = enc_dec wav $(SRC) $(FMT) "-b 128k -c $(CODEC) $(ENCOPTS)" wav "-c pcm_s16le $(DECOPTS)" -keep
fate-acodec-%: CMP_UNIT = 2

FATE_ACODEC_PCM = alaw mulaw                                            \
                  s8 u8                                                 \
                  s16be s16le                                           \
                  s24be s24le                                           \
                  s32be s32le                                           \
                  f32be f32le                                           \
                  f64be f64le

FATE_ACODEC += $(FATE_ACODEC_PCM:%=fate-acodec-pcm-%)

fate-acodec-pcm-%: FMT = wav
fate-acodec-pcm-%: CODEC = pcm_$(@:fate-acodec-pcm-%=%)

fate-acodec-pcm-s8:   FMT = mov
fate-acodec-pcm-s%be: FMT = mov
fate-acodec-pcm-f%be: FMT = au

FATE_ACODEC_ADPCM = adx ima_qt ima_wav ms swf yamaha
FATE_ACODEC += $(FATE_ACODEC_ADPCM:%=fate-acodec-adpcm-%)

fate-acodec-adpcm-%: CODEC = adpcm_$(@:fate-acodec-adpcm-%=%)

fate-acodec-adpcm-adx:     FMT = adx
fate-acodec-adpcm-ima_qt:  FMT = aiff
fate-acodec-adpcm-ima_wav: FMT = wav
fate-acodec-adpcm-ms:      FMT = wav
fate-acodec-adpcm-swf:     FMT = flv
fate-acodec-adpcm-yamaha:  FMT = wav

FATE_ACODEC += fate-acodec-mp2
fate-acodec-mp2: FMT = mp2
fate-acodec-mp2: CMP_SHIFT = -1924

FATE_ACODEC += fate-acodec-alac
fate-acodec-alac: FMT = mov
fate-acodec-alac: CODEC = alac -compression_level 1

FATE_ACODEC += fate-acodec-flac
fate-acodec-flac: FMT = flac
fate-acodec-flac: CODEC = flac -compression_level 2

FATE_ACODEC += fate-acodec-g723_1
fate-acodec-g723_1: FMT = g723_1
fate-acodec-g723_1: CODEC = g723_1
fate-acodec-g723_1: ENCOPTS = -b:a 6.3k -ac 1 -ar 8000
#fate-acodec-g723_1: DECOPTS = -ac 2 -ar 44100

FATE_ACODEC += fate-acodec-ra144
fate-acodec-ra144: FMT = rm
fate-acodec-ra144: CODEC = real_144
fate-acodec-ra144: ENCOPTS = -ac 1
fate-acodec-ra144: DECOPTS = -ac 2
fate-acodec-ra144: CMP_SHIFT = -640

FATE_ACODEC += fate-acodec-roqaudio
fate-acodec-roqaudio: FMT = roq
fate-acodec-roqaudio: CODEC = roq_dpcm
fate-acodec-roqaudio: ENCOPTS = -ar 22050
fate-acodec-roqaudio: DECOPTS = -ar 44100

$(FATE_ACODEC): tests/data/asynth-44100-2.wav

FATE_AVCONV += $(FATE_ACODEC)
fate-acodec: $(FATE_ACODEC)
