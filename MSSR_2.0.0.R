library(FCSlib)
library(akima)
library(matlab)

# Stack analysis
tMSSR <- function(img, amp, psf, order, mesh = TRUE, intNorm = TRUE){#, excOL = FALSE, OutLiersTh = 0.3){
  di <- dim(img)
  MSSRDFinal <- array(data = NA, dim = c(di[1]*amp, di[2]*amp, di[3]))
  for(i in 1:dim(img)[3]){
    MSSRDFinal[,,i] <- sfMSSR(img = img[, , i], amp = amp, psf = psf, order = order, mesh = mesh,
                              intNorm = intNorm)
  }
  return(MSSRDFinal)
}
# Single frame analysis
sfMSSR <- function(img, amp, psf, order, mesh = TRUE, intNorm = TRUE) {
  di <- dim(img)
  hs <- round(0.5*psf*amp)
  if(hs<1){
    hs <- 1
  }
  if(amp > 1){
    AMP <- bicubic.grid(x = 1:di[1], y = 1:di[2], z = img, nx = di[1]*amp, ny = di[2]*amp)$z
    if(mesh){
      AMP <- meshing(img = AMP, desp = ceiling(amp/2))
    }
  } else{
    AMP <- img
  }
  xPad <- padarray(AMP, c(hs, hs), "symmetric", "both")
  
  M <- array(data = 0, dim = dim(AMP))
  di <- dim(M)
  for(i in -hs:hs){
    for(j in -hs:hs){
      if((i!=0 || j!=0) && (sqrt(i^2 + j^2) <= hs)){
        xThis <- xPad[(hs+i+1):(di[1]+hs+i), (hs+j+1):(di[2]+hs+j)]
        M = pmax(M, abs(AMP - xThis))
      }
    }
  }
  
  weightAccum <- yAccum <- array(data = 0, dim = dim(AMP))
  for(i in -hs:hs){
    for(j in -hs:hs){
      if((i!=0 || j!=0) && (sqrt(i^2 + j^2) <= hs)){
        spatialKernel <- exp(-(i^2 + j^2) / (hs^2))
        xThis <- xPad[(hs+i+1):(di[1]+hs+i), (hs+j+1):(di[2]+hs+j)]
        xDiffSq0 <- ((AMP - xThis) / M)^2
        intensityKernel <- exp(-xDiffSq0)
        
        weightThis <- spatialKernel * intensityKernel
        weightAccum <- weightAccum + weightThis
        yAccum <- yAccum + (xThis * weightThis)
      }
    }
  }
  
  MS <- AMP - (yAccum / weightAccum)
  MS[which(MS<0)] <- 0
  MS[which(is.na(MS))] <- 0
  
  I0 <- MS / max(MS)
  I3 <- I0
  x3 <- AMP / max(AMP)
  if(order>0){
    for(i in 1:order){
      I4 <- x3 - I3
      I5 <- max(I4) - I4
      I5 <- I5 / max(I5)
      I6 <- I5 * I3
      I7 <- I6 / max(I6)
      x3 <- I3
      I3 <- I7
    }
  }
  IMSSRD <- rot90(I3,3)
  if(intNorm){
    IMSSRD <- IMSSRD*AMP# Intensity Normalization
  }
  return(IMSSRD)
}
excludeOutliers <- function(IMSSRD, OutLiersTh){
  th = (100-OutLiersTh)/100
  
  IMSSRD <- IMSSRD*max(AMP)
  # print(min(IMSSRD))
  # print(max(IMSSRD))
  x <- seq(min(IMSSRD),max(IMSSRD), 1)
  Fn <- ecdf(IMSSRD)
  f <- Fn(x)
  x[which(f>th)]
  mnX <- min(x[which(f>th)])
  IMSSRD[which(IMSSRD>mnX)] <- mnX
  IMSSRD <- IMSSRD/max(AMP)
  
  x <- seq(min(AMP),max(AMP), 1)
  Fn <- ecdf(AMP)
  f <- Fn(x)
  x[which(f>th)]
  mnX <- min(x[which(f>th)])
  AMP[which(AMP>mnX)] <- mnX
}
# Mesh Compensation
meshing <- function(img, desp){
  img <- padarray(img, c(desp, desp), "symmetric", "both") # Genera una matriz reflejada en todas las dimensiones
  di <- dim(img)
  imgHD <- rbind(img[(di[1]-desp):di[1],], img[1:(di[1]-desp-1),])
  imgHI <- rbind(img[(desp+1):di[1],], img[1:(desp),])
  
  imgVD <- cbind(img[, (di[2]-desp):di[2]], img[, 1:(di[2]-desp-1)])
  imgVI <- cbind(img[, (desp+1):di[2]], img[, 1:(desp)])
  
  imgHVC <- (img + (imgHD)  + (imgHI) + (imgVD)  + (imgVI)) / (5)
  return(imgHVC[(desp+1):(di[1]-desp), (desp+1):(di[2]-desp)])
}
# Temporal pixel-wise analysis
TPM <- function(img){
  di <- dim(img)
  SumTPM <- array(data = 0, dim = di[1:2])
  iTPM <- array(data = 0, dim = di[1:2])
  for(i in 1:di[3]){
    SumTPM <- SumTPM + img[,,i]
  }
  for(i in 1:di[3]){
    iTPM <- iTPM + (img[,,i] * SumTPM)
  }
  return(iTPM)
}
imVar<-function(img){
  di<-dim(img)
  X<-di[1]
  Y<-di[2]
  Ivar<-array(NA, dim = c(X,Y))
  for(i in 1:(X)){ 
    for(j in 1:(Y)){  
      Ivar[i,j]<-var(img[i,j,], na.rm = T)
    }
  }
  return(Ivar)
}
imMean<-function(img){
  di<-dim(img)
  if(length(di)!=3) return(img)
  if(di[3]<2) return(img)
  X<-di[1]
  Y<-di[2]
  Imean<-array(NA, dim = c(X,Y))
  for(i in 1:(X)){ 
    for(j in 1:(Y)){  
      Imean[i,j]<-mean(img[i,j,], na.rm = T)
    }
  }
  return(Imean)
}