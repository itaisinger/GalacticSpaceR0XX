{
  "resourceType": "GMObject",
  "resourceVersion": "1.0",
  "name": "obj_black_hole",
  "spriteId": {
    "name": "spr_black_hole",
    "path": "sprites/spr_black_hole/spr_black_hole.yy",
  },
  "solid": false,
  "visible": true,
  "managed": true,
  "spriteMaskId": null,
  "persistent": false,
  "parentObjectId": {
    "name": "obj_meteor",
    "path": "objects/obj_meteor/obj_meteor.yy",
  },
  "physicsObject": false,
  "physicsSensor": false,
  "physicsShape": 1,
  "physicsGroup": 1,
  "physicsDensity": 0.5,
  "physicsRestitution": 0.1,
  "physicsLinearDamping": 0.1,
  "physicsAngularDamping": 0.1,
  "physicsFriction": 0.2,
  "physicsStartAwake": true,
  "physicsKinematic": false,
  "physicsShapePoints": [],
  "eventList": [
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":0,"eventType":0,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":0,"eventType":1,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":0,"eventType":3,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":0,"eventType":8,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":0,"eventType":4,"collisionObjectId":{"name":"obj_shot","path":"objects/obj_shot/obj_shot.yy",},},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":0,"eventType":4,"collisionObjectId":{"name":"obj_player","path":"objects/obj_player/obj_player.yy",},},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":0,"eventType":2,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":1,"eventType":2,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":73,"eventType":8,"collisionObjectId":null,},
  ],
  "properties": [],
  "overriddenProperties": [
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"hp","path":"objects/obj_meteor/obj_meteor.yy",},"objectId":{"name":"obj_meteor","path":"objects/obj_meteor/obj_meteor.yy",},"value":"500",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"size","path":"objects/obj_meteor/obj_meteor.yy",},"objectId":{"name":"obj_meteor","path":"objects/obj_meteor/obj_meteor.yy",},"value":"10",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"spd","path":"objects/obj_meteor/obj_meteor.yy",},"objectId":{"name":"obj_meteor","path":"objects/obj_meteor/obj_meteor.yy",},"value":"0",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"reward","path":"objects/obj_meteor/obj_meteor.yy",},"objectId":{"name":"obj_meteor","path":"objects/obj_meteor/obj_meteor.yy",},"value":"200",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"color","path":"objects/obj_meteor/obj_meteor.yy",},"objectId":{"name":"obj_meteor","path":"objects/obj_meteor/obj_meteor.yy",},"value":"$FFCB89E5",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"spin_max","path":"objects/obj_meteor/obj_meteor.yy",},"objectId":{"name":"obj_meteor","path":"objects/obj_meteor/obj_meteor.yy",},"value":"0",},
  ],
  "parent": {
    "name": "meteors",
    "path": "folders/Objects/game objects/meteors.yy",
  },
}