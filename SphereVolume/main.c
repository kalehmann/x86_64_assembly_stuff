/******************************************************************************
 * Calculate the volume of a v_sphere                                         *
 * Copyright (c) 2015 by Karsten Lehmann                                      *
 ******************************************************************************/

#include <stdio.h>

extern float v_kugel(float r);

float r;

int main() {
    printf("#################\n# Sphere volume #\n#################\n\n");
    printf("Please enter the raidus : ");
    scanf("%f", &r);
    printf("Volume : %.2f\n", v_kugel(r));
    return 0;
}
