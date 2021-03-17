#   Detect faces check whether

########################
# Setup the environment with libraries and the key service
########################

# Use the paws library for easy access to aws
# Note: You will need to authenticate. For this project, I have my credentials in an
# AWS configuration; so, paws looks there for them.
# paws provides good information on how to do this:
# https://github.com/paws-r/paws/blob/master/docs/credentials.md
library(paws)

# Use the magick library for image functions.
library(magick)

# This application is going to use the rekognition service from AWS. The paws documentation is here:
# # https://paws-r.github.io/docs/rekognition/
svc <- rekognition()

########################
# First, create a new collection that you will use to store the set of identified faces. This will be
# the library of faces that you use for determining someone's identity
########################

# Do not need to add an image to a collection or create a collection
#faceCollection already exists in the file


########################
# Second, take a single photo that has multiple kids in it. Label each kid with his name and the
# emotions that are expressed in the photo.
########################

## Create this into a function 

# Get information about a group photo

allImages = function () {
  path = "/Users/rentaluser/desktop/thesisVideo/videos/FullVideo/videoFaceAnalysis_temp_pilotTeam1VeroRound3" 
  #path  = folderPath
  
  # How to get all the images in this path 
  img_files = list.files(path=path, full.names=T)
  
  
  # check wheter this works and check whether it accurately captures the people? 
  # if this 
  for(img in img_files) {
    print(paste(img))
    print("HELLO THRE")
    createImages(img)
    
  }

}


createImages = function(photoPath) {
  grp.photo = photoPath

# Read the photo using magick
  img = image_read(grp.photo)

# Get basic informatino about the photo that will be useful for annotating
  inf = image_info(img)

# Detect the faces in the image and pull all attributes associated with faces
  o = svc$detect_faces(Image=list(Bytes=grp.photo), Attributes="ALL")

# Just get the face details
  all_faces = o$FaceDetails
  length(all_faces)

# Loop through the faces, one by one. For each face, draw a rectangle around it, add the kid's name, and emotions

# Duplicate the original image to have something to annotate and output
  new.img = img

  for(i in 1:length(all_faces)) {
    #print(paste(i))
    #print("faces id")
    #(paste(all_faces[i]))
   face = all_faces[[i]]
  #for (face in all_faces){
 # face  = all_faces
   # print(paste(face))
  
# Prepare a label that collapses across the emotions data provided by rekognition. Give the type of
# emotion and the confidence that AWS has in its expression.
  emo.label = ""
  for(emo in face$Emotions) {
  emo.label = paste(emo.label,emo$Type, " = ", round(emo$Confidence, 2), "\n", sep="")
  }

# Identify the coordinates of the face. Note that AWS returns percentage values of the total image size. This is
# why the image info object above is needed
  box = face$BoundingBox
  image_width=inf$width
  image_height=inf$height
  x1 = box$Left*image_width
  y1 = box$Top*image_height
  x2 = x1 + box$Width*image_width
  y2 = y1 + box$Height*image_height  

# Create a subset image in memory that is just cropped around the focal face
  img.crop = image_crop(img, paste(box$Width*image_width,"x",box$Height*image_height,"+",x1,"+",y1, sep=""))
  img.crop = image_write(img.crop, path = NULL, format = "png")

# Search in a specified collection to see if we can label the identity of the face is in this crop
  o = svc$search_faces_by_image(CollectionId="faceCollection",Image=list(Bytes=img.crop), FaceMatchThreshold=70)

# Create a graphics device version of the larger photo that we can annotate
  new.img = image_draw(new.img)

# If the face matches something in the collection, then add the name to the image
  if(length(o$FaceMatches) > 0) {
  faceName = o$FaceMatches[[1]]$Face$ExternalImageId
  faceConfidence = round(o$FaceMatches[[1]]$Face$Confidence,3)
  print(paste("Detected: ",faceName, sep=""))
  faceId = i

  # annotate with the face id 
  text(x=x1+(box$Width*image_width)/2, y=y1+ 30,i, adj=0.5, cex=2, col="blue")
  
  # annotate with the name of the person
  text(x=x1+(box$Width*image_width)/2, y=y1,faceName, adj=0.5, cex=3, col="green")
}

# Draw a rectangle around the face
  rect(x1,y1,x2,y2, border="red", lty="dashed", lwd=5)   
  
  print(x1)
# Annotate the photo with the emotions information
  text(x=x1+ 0.8 +(box$Width*image_width)/2, y=y1+50,emo.label, pos=1, cex=1, col="red")     

  dev.off()
}

# Write the image out to file
  # The path for the new Image 
  
  annotated = "/Users/rentaluser/desktop/thesisVideo/videos/annotatedImages/pilot/team1_r3_full/" 
  
  photoNum = strsplit(photoPath, "/")[[1]][9]

  newPath = paste(annotated, photoNum)
  
  print(newPath)
  
  image_write(new.img, path= newPath, format="png")
}