#!/bin/bash


## $1 -$3 argumendid maastike on protsendid, neljanda pindala arvutab eelnevatest (kogu ala 25x25),
## eeldan, et üks külg on kõigil maastikel 25, teise külje arvutan välja antud protsendi kaudu
## $4-$7 kõrgused (proovisin: 5 10 20 25)
## $8 puude ja kivide kogus (proovisin: 3)
## $9-$10 puude ja kivide asukohad (pose-i x kooridnaat),  
## x puule ja x kivile (järgmine puu/kivi eelmisest +10),

## üks näide millega katsetasin maailma genereerimist: ./skript.sh 20 40 20 10 20 25 30 3 5 9

## muudan veidi puu ja kivi x-koordinaati, et üksteise otsas ei asuks teine kivi ja teine puu
k1=`expr "$9+10" | bc -l`
p1=`expr "${10}+20" | bc -l`



a=100
b=25

## arvutan iga maastiku teise külje eeldades, et üks on 25 
a1=`expr "$1 / $a * 25" | bc -l` 
a2=`expr "$2 / $a * 25" | bc -l`
a3=`expr "$3 / $a * 25" | bc -l`
a4=`expr "100-$1-$2-$3 / $a * 25" | bc -l`

echo "$a1"
echo "$a2"
echo "$a3"
echo "$a4"


cat << fille > file.xml 

<?xml version="1.0"?>
<sdf version="1.4">
<world name="default">
<scene>
 <grid>false</grid>
</scene>
<include>
      <uri>model://ground_plane</uri>
</include>

<model name="my_ground_plane">
  <static>true</static>
   <pose>0 0 $4 0 0 0</pose>
    <link name="link">
      <collision name="collision">
        <geometry>
          <plane>
            <normal>0 0 0</normal>
            <size>20 $a1</size>
          </plane>
        </geometry>
      </collision>
      <visual name="visual">
        <cast_shadows>false</cast_shadows>
        <geometry>
          <plane>
            <normal>0 0 0</normal>
            <size>25 $a1</size>
          </plane>
        </geometry>
        <material>
          <script>
            <uri>model://my_ground_plane/materials/scripts/my_ground_plane.material</uri>
            <name>MyGroundPlane/Terrain</name>
          </script>
        </material>
      </visual>
    </link>
  </model>

<population name="rock1_population">
      <model name="rock1">
        <include>
          <uri>model://rock1</uri>
        </include>
      </model>
      <pose>$9 2 0 0 0 0</pose>
      <box>
        <size>20 20 2</size>
      </box>
      <model_count>$8</model_count>
       <distribution>
        <type>uniform</type>
        <step>4 5 0</step>
      </distribution>
    </population>

<model name="my_ground_plane">
  <static>true</static>
   <pose>0 0 $5 0 0 0</pose>
    <link name="link">
      <collision name="collision">
        <geometry>
          <plane>
            <normal>0 0 0</normal>
            <size>25 $a2</size>
          </plane>
        </geometry>
      </collision>
      <visual name="visual">
        <cast_shadows>false</cast_shadows>
        <geometry>
          <plane>
            <normal>0 0 0</normal>
            <size>20 $a2</size>
          </plane>
        </geometry>
        <material>
          <script>
            <uri>model://my_ground_plane/materials/scripts/my_ground_plane.material</uri>
            <name>MyGroundPlane/Granite</name>
          </script>
        </material>
      </visual>
    </link>
  </model>

<population name="rock2_population">
      <model name="rock2">
        <include>
          <uri>model://rock2</uri>
        </include>
      </model>
      <pose>$k1 0 0 0 0 0</pose>
      <box>
        <size>20 20 2</size>
      </box>
      <model_count>$8</model_count>
      <distribution>
        <type>uniform</type>
        <step>6 6 0</step>
      </distribution>
    </population>

<model name="my_ground_plane">
  <static>true</static>
   <pose>7 7 $6 0 0 0</pose>
    <link name="link">
      <collision name="collision">
        <geometry>
          <plane>
            <normal>0 0 0</normal>
            <size>25 $a3</size>
          </plane>
        </geometry>
      </collision>
      <visual name="visual">
        <cast_shadows>false</cast_shadows>
        <geometry>
          <plane>
            <normal>0 0 0</normal>
            <size>25 $a3</size>
          </plane>
        </geometry>
        <material>
          <script>
            <uri>model://my_ground_plane/materials/scripts/my_ground_plane.material</uri>
            <name>MyGroundPlane/Sidewalk</name>
          </script>
        </material>
      </visual>
    </link>
  </model>


<model name="my_ground_plane">
  <static>true</static>
   <pose>1 15 $7 0 0 0</pose>
    <link name="link">
      <collision name="collision">
        <geometry>
          <plane>
            <normal>0 0 0</normal>
            <size>25 $a4</size>
          </plane>
        </geometry>
      </collision>
      <visual name="visual">
        <cast_shadows>false</cast_shadows>
        <geometry>
          <plane>
            <normal>0 0 0</normal>
            <size>25 $a4</size>
          </plane>
        </geometry>
        <material>
          <script>
            <uri>model://my_ground_plane/materials/scripts/my_ground_plane.material</uri>
            <name>MyGroundPlane/Grass</name>
          </script>
        </material>
      </visual>
    </link>
  </model>

<population name="tree1_population">
      <model name="tree1">
        <include>
          <uri>model://tree1</uri>
        </include>
      </model>
      <pose>${10} 15 0 0 0 0</pose>
      <box>
        <size>20 20 30</size>
      </box>
      <model_count>$8</model_count>
      <distribution>
        <type>linear-y</type>
      </distribution>
    </population>

<population name="tree2_population">
      <model name="tree2">
        <include>
          <uri>model://tree2</uri>
        </include>
      </model>
      <pose>$p1 0 0 0 0 0</pose>
      <box>
        <size>20 20 30</size>
      </box>
      <model_count>$8</model_count>
      <distribution>
         <type>linear-x</type>
         <step>5 5 0</step>
      </distribution>
    </population>

</world>
</sdf>
fille






 




