PImage img1,img2;

size(600, 800);
img1 = loadImage("image1.jpg");



img2 = loadImage("image1.jpg"); //loading same image again


loadPixels(); 
img1.loadPixels(); 
img2.loadPixels();

//converting color image to grayscale image
for (int y = 0; y < img1.height; y++)     
  for (int x = 0; x < img1.width; x++) {
    int index = x + y * img1.width;
    float r = red (img1.pixels[index]);
    float g = green(img1.pixels[index]);
    float b = blue(img1.pixels[index]);      
    pixels[index] =  color(0.21*r + 0.72*g + 0.07*b);
  }
  
updatePixels();

//applying soble filter for the grayscale image1
float[][] filterx = 
{{ -1, -2, -1 }, 
  { 0, 0, 0 }, 
  { 1, 2, 1 }};

float[][] filtery = 
{{ -1, 0, 1 }, 
  { -2, 0, 2 }, 
  { -1, 0, 1 }};
float theta1=0;
//initializing values for matrix 
float Pi = 3.14;
int n =8;
//float e0=0, e1=0, e2=0, e3=0, e4=0, e5=0, e6=0, e7=0;
float mx [][] = new float [81] [n];
float my [][] = new float [81] [n];
for (int y = 1; y < img1.height-1; y++) 
  for (int x = 1; x < img1.width-1; x++) {
    float gx = 0;
    float gy = 0;
    float e0=0, e1=0, e2=0, e3=0, e4=0, e5=0, e6=0, e7=0;
    float s=0;
    for (int ky = -1; ky <= 1; ky++) 
      for (int kx = -1; kx <= 1; kx++) {
         int index = (y + ky) * img1.width + (x + kx);
        float r = brightness(img1.pixels[index]);
        
        gx += filterx[ky+1][kx+1] * r;
        gy += filtery[ky+1][kx+1] * r;
      }
    s=abs(gx)+abs(gy); //calculating the magnitude of gradient vectors
    pixels[y*img1.width + x] = color(s);
  
theta1 = atan(gy/ gx); 

if (gx > 0 )
{
  theta1 = theta1;
}
else if (gx < 0)
{
  theta1 = theta1 + Pi;
} 
else if (gx == 0)
{
  if (gy > 0 )
  {
    theta1 = Pi/2;
  }
  else if (gy < 0)
  {
    theta1  = -Pi/2;
  }
}

//theta is 2*pi/n and lies in these areas
 if(theta1 >= 0 && theta1 <= Pi/4)
 {
 e0 = abs(gx) + abs(gy);
 }
 if(theta1 >= Pi/4 && theta1 <= Pi/2)
 {
 e1 = abs(gx) + abs(gy);
 }
 if(theta1 >= Pi/2 && theta1 <= 3*Pi/4)
 {
 e2 = abs(gx) + abs(gy);
 }
 if(theta1 >= 3*Pi/4 && theta1 <= Pi)
 {
 e3 = abs(gx) + abs(gy);
 }
 if(theta1 >= Pi && theta1 <= 5*Pi/4)
 {
 e4 = abs(gx) + abs(gy);
 }
 if(theta1 >= 5*Pi/4 && theta1 <= 3*Pi/2)
 {
 e5 = abs(gx) + abs(gy);
 }
 if(theta1 >= 3*Pi/2 && theta1 <= 7*Pi/4)
 {
 e6 = abs(gx) + abs(gy);
 }
 if(theta1 >= 7*Pi/4 && theta1 <= 2*Pi)
 {
 e7 = abs(gx) + abs(gy);
 }
 //obtaining the 9*9 block matrix
 int p = 9*x/(img1.width);
 int g = 9*y/(img1.height);
 int d = p*9+g;
 mx [d] [0]+= e0;
 mx [d] [1]+= e1;
 mx [d] [2]+= e2;
 mx [d] [3]+= e3;
 mx [d] [4]+= e4;
 mx [d] [5]+= e5;
 mx [d] [6]+= e6;
 mx [d] [7]+= e7;
 
 } 
 //converting image2 from colour to grayscale
img2.resize(500,400); 
 for (int y = 0; y < img2.height; y++)
  for (int x = 0; x < img2.width; x++) {
    int index = x + y * img2.width;
    float r = red (img2.pixels[index]);
    float g = green(img2.pixels[index]);
    float b = blue(img2.pixels[index]);      
    pixels[index] =  color(0.21*r + 0.72*g + 0.07*b);
  }
 
 //println(theta1);
// updatePixels();



//calculating gradient values
for (int y = 1; y < img2.height-1; y++) 
  for (int x = 1; x < img2.width-1; x++) {
    float gx = 0;
    float gy = 0;
    float e0=0, e1=0, e2=0, e3=0, e4=0, e5=0, e6=0, e7=0;
    float s=0;
    for (int ky = -1; ky <= 1; ky++) 
      for (int kx = -1; kx <= 1; kx++) {
        int index = (y + ky) * img2.width + (x + kx);
        float r = brightness(img2.pixels[index]);
        gx += filterx[ky+1][kx+1] * r;
        gy += filtery[ky+1][kx+1] * r;
      }
    s=abs(gx)+abs(gy);
    pixels[y*img1.width + x] = color(s);
  

theta1 = atan(gy/ gx); 
if (gx > 0 )
{
  theta1 = theta1;
}
else if (gx < 0)
{
  theta1 = theta1 + Pi;
} 
else if (gx == 0)
{
  if (gy > 0 )
  {
    theta1 = Pi/2;
  }
  else if (gy < 0)
  {
    theta1  = -Pi/2;
  }
}


 if(theta1 > 0 && theta1 <= Pi/4)
 {
 e0 = abs(gx) + abs(gy);
 }
 if(theta1 > Pi/4 && theta1 <= Pi/2)
 {
 e1 = abs(gx) + abs(gy);
 }
 if(theta1 > Pi/2 && theta1 <= 3*Pi/4)
 {
 e2 = abs(gx) + abs(gy);
 }
 if(theta1 > 3*Pi/4 && theta1 <= Pi)
 {
 e3 = abs(gx) + abs(gy);
 }
 if(theta1 > Pi && theta1 <= 5*Pi/4)
 {
 e4 = abs(gx) + abs(gy);
 }
 if(theta1 > 5*Pi/4 && theta1 <= 3*Pi/2)
 {
 e5 = abs(gx) + abs(gy);
 }
 if(theta1 > 3*Pi/2 && theta1 <= 7*Pi/4)
 {
 e6 = abs(gx) + abs(gy);
 }
 if(theta1 > 7*Pi/4 && theta1 <= 2*Pi)
 {
 e7 = abs(gx) + abs(gy);
 }
 //obtaining the 9*9 block matrix
 int p = 9*x/(img2.width); //co-ordinates of block
 int g = 9*y/(img2.height); 
 int d = p*9+g; //index will calculate the row position of the 2d matrix
 my [d] [0]+= e0;
 my [d] [1]+= e1;
 my [d] [2]+= e2;
 my [d] [3]+= e3;
 my [d] [4]+= e4;
 my [d] [5]+= e5;
 my [d] [6]+= e6;
 my [d] [7]+= e7;
 
 } 
 
 //calculation of similarities of 2 signatures given below
float D1 = 0;
float D2 = 0;
float Numerator=0;
for(int i=0;i<81;i++)
for(int j=0;j<8;j++) {
 Numerator+=mx[i][j] * my[i][j];
 D1+=mx[i][j]*mx[i][j];
D2+=my[i][j]*my[i][j];
 }
 
float sim = (Numerator) /((sqrt(D1))*(sqrt(D2)));// calculation of the cosine value of similarities
 println("The similarity of 2 signature in the images is " +sim);
 updatePixels();
