clear;
% image = imread("test.PNG");
image = imread("fire02.jpg");
% image = imread("002.jpg");

% Convert image to HSV color space
hsvImage = rgb2hsv(image);


% Hue (H): Represents the color itself.
% Saturation (S): Represents the intensity of the color.
% Value (V): Represents the brightness of the color.

%Red color range in HSV [Hue, Saturation,value]


% Define red color range in HSV
lowerHSV = [0, 0.4, 0.2]; % Adjusted lower bound of the range for red color
upperHSV = [0.1, 1, 1];   % Adjusted upper bound of the range for red color

% Threshold the HSV image to get the red color only
binaryImage = (hsvImage(:, :, 1) >= lowerHSV(1)) & (hsvImage(:, :, 1) <= upperHSV(1)) & ...
              (hsvImage(:, :, 2) >= lowerHSV(2)) & (hsvImage(:, :, 2) <= upperHSV(2)) & ...
              (hsvImage(:, :, 3) >= lowerHSV(3)) & (hsvImage(:, :, 3) <= upperHSV(3));
               
labelledImage = bwlabel(binaryImage,4);
imshow(labelledImage);

stats = regionprops(labelledImage,'BoundingBox');

percentageRed = sum(binaryImage(:)) / numel(binaryImage) *100;



% Detect if there is a red car in the image

if percentageRed >1 
    disp('There is a red car in the image!');
else
    disp('There is no red car in the image.');
end

%maybe use this as well for detecting an object

%%%%%%%%%%%%%COMBINE INTO 1 FUNCTION%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Assuming you have a labeled binary image
labeledImage = bwlabel(binaryImage);

% Use regionprops to get properties for each region
stats = regionprops(labeledImage, 'BoundingBox', 'PixelIdxList');

% Check if any regions are found
if ~isempty(stats)
    % Find the region with the maximum area
    maxArea = 0;
    maxAreaIndex = 0;

    for i = 1:numel(stats)
        % Calculate area based on the length of PixelIdxList
        area = length(stats(i).PixelIdxList);

        % Update maxArea and maxAreaIndex if a larger area is found
        if area > maxArea
            maxArea = area;
            maxAreaIndex = i;
        end
    end

    % Retrieve bounding box information for the largest region
    boundingBox = stats(maxAreaIndex).BoundingBox;

    % Display the original image and the bounding box with blue color
    figure;
    imshow(image);
    hold on;

    % Draw the bounding box for the largest region with blue color
    rectangle('Position', boundingBox, 'EdgeColor', 'g', 'LineWidth', 2);

    hold off;

    disp('Largest red region found and highlighted.');
else
    disp('No red regions found.');
end





% Check if any region is found
if ~isempty(stats)
    % Iterate over all regions
    for i = 1:numel(stats)
        % Retrieve the BoundingBox of the current region
        bound_box = stats(i).BoundingBox;

        % Retrieve the width and height of the BoundingBox
        bound_box_width = bound_box(3);
        bound_box_height = bound_box(4);

        % Calculate the width-to-height ratio of the BoundingBox
        ratio = bound_box_width / bound_box_height;

        % If the ratio is close to 1:3, display a message
        if abs(ratio - 1/3) < 0.1  % Adjust the threshold as needed
            disp('Detected a car with a ratio of 1:3');
        end
    end
else
    disp('No regions found.');
end





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{
clear;
% img = imread("oversized.jpg");
 img = imread("002.jpg");


% Converting the image from RBG to HSV
hsvImage = rgb2hsv(img);

% Extracting the hue, saturation, and value channels
hueChannel = hsvImage(:, :,1);
saturationChannel = hsvImage(:,:,2);
valueChannel = hsvImage(:,:,3);

lowerRed = [0.3,0.2,0.2];
upperRed = [1,1,1];

% binary mask based on the red colour range

redMask = (hueChannel >= lowerRed(1)) & (hueChannel <= upperRed(1)) & ...
    (saturationChannel >=lowerRed(2)) & (saturationChannel <= upperRed(2)) &...
    (valueChannel >= lowerRed(3)) & (valueChannel <= upperRed(3)); 

% using regions to get properties of connected components in the mask
stats = regionprops(redMask,'BoundingBox');

imshow(redMask)
if any(redMask(:))
    disp('The car is a fire truck!');
else
    disp('The car is not a fire truck.');
end

clear
%}



%{

labeledImage = bwlabel(binaryImage);

% Use regionprops to get bounding box information
stats = regionprops(labeledImage, 'BoundingBox');

% Display the original image and the bounding boxes
figure;
imshow(image);
hold on;

for i = 1:numel(stats)
    % Retrieve bounding box information
    boundingBox = stats(i).BoundingBox;

    % Draw the bounding box on the image
    rectangle('Position', boundingBox, 'EdgeColor', 'y', 'LineWidth', 2);
end

hold off;

%}

%{

labeledImage = bwlabel(binaryImage);

% Use regionprops to get bounding box and area information
stats = regionprops(labeledImage, 'BoundingBox', 'Area');

% Check if any regions are found
if ~isempty(stats)
    % Find the region with the maximum area
    [~, maxAreaIndex] = max([stats.Area]);

    % Retrieve bounding box information for the largest region
    boundingBox = stats(maxAreaIndex).BoundingBox;

    % Display the original image and the bounding box with blue color
    figure;
    imshow(image);
    hold on;

    % Draw the bounding box for the largest region with blue color
    rectangle('Position', boundingBox, 'EdgeColor', 'b', 'LineWidth', 2);

    hold off;

    disp('Largest red region found and highlighted.');
else
    disp('No red regions found.');
end

%}

