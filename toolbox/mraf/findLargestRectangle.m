%  finds largest rectangle regions within all points set to 1.
%  input: I       - B/W boolean matrix or output of findLargestSquare
%         minSize - [height width] - minimum width and height on regions of 
%                   interest (used to restrict final choise)
%         crit    - Optimazation Criteria parameters to optimize:
%                    crit(1)*height + crit(2)*width + crit(3)*height*width
%  output: 
%          C    - value of the optimization criteria "crit" calculated for 
%                 each pixel 
%          W, H - for each pixel I(r,c) return height and width of the largest 
%                 all-white rectangle with its upper-left corner at I(r,c)
%          M    - Mask the largest all-white rectangle of the image
%