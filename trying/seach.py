var= {
  "Images": [
    {
      "ImageId": "string",
      "Name": "string",
      "Description": "string",
      "Tags": ["string", "string", ...],
      "Created": "datetime",
      "Owner": "string"
    },{
         "ImageId": "string",
      "Name": "string",
      "Description": "string",
      "Tags": ["string", "string", ...],
      "Created": "datetime",
      "Owner": "string"
    }
  ]
}

for indexs in var["Images"]:
    print(indexs["Tags"][0])