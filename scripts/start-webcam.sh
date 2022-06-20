# https://gist.github.com/jessarcher/39fbabd9864077a0a1349c24c8277af5
gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video2
