#include "LibC.h"

cpSpaceDebugColor LAColor(float l, float a){
	cpSpaceDebugColor color = {l, l, l, a};
	return color;
}

cpSpaceDebugColor RGBAColor(float r, float g, float b, float a){
	cpSpaceDebugColor color = {r, g, b, a};
	return color;
}

cpSpaceDebugColor Colors[] = {
	{0xb5/255.0f, 0x89/255.0f, 0x00/255.0f, 1.0f},
	{0xcb/255.0f, 0x4b/255.0f, 0x16/255.0f, 1.0f},
	{0xdc/255.0f, 0x32/255.0f, 0x2f/255.0f, 1.0f},
	{0xd3/255.0f, 0x36/255.0f, 0x82/255.0f, 1.0f},
	{0x6c/255.0f, 0x71/255.0f, 0xc4/255.0f, 1.0f},
	{0x26/255.0f, 0x8b/255.0f, 0xd2/255.0f, 1.0f},
	{0x2a/255.0f, 0xa1/255.0f, 0x98/255.0f, 1.0f},
	{0x85/255.0f, 0x99/255.0f, 0x00/255.0f, 1.0f},
};

cpSpaceDebugColor ColorForShape(cpShape *shape, cpDataPointer data)
{
	if(cpShapeGetSensor(shape)){
		return LAColor(1.0f, 0.1f);
	} else {
		cpBody *body = cpShapeGetBody(shape);
		
		if(cpBodyIsSleeping(body)){
			return RGBAColor(0x58/255.0f, 0x6e/255.0f, 0x75/255.0f, 1.0f);
		} else if(body->sleeping.idleTime > shape->space->sleepTimeThreshold) {
			return RGBAColor(0x93/255.0f, 0xa1/255.0f, 0xa1/255.0f, 1.0f);
		} else {
			uint32_t val = (uint32_t)shape->hashid;
			
			// scramble the bits up using Robert Jenkins' 32 bit integer hash function
			val = (val+0x7ed55d16) + (val<<12);
			val = (val^0xc761c23c) ^ (val>>19);
			val = (val+0x165667b1) + (val<<5);
			val = (val+0xd3a2646c) ^ (val<<9);
			val = (val+0xfd7046c5) + (val<<3);
			val = (val^0xb55a4f09) ^ (val>>16);
			return Colors[val & 0x7];
		}
	}
}