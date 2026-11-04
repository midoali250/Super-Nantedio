import sys, pygame
pygame.init();s=pygame.Surface((256,256),pygame.SRCALPHA);s.fill((31,43,75));pygame.draw.rect(s,(230,48,46),(36,55,184,55),border_radius=18);pygame.draw.rect(s,(244,200,141),(67,110,122,90),border_radius=20);pygame.draw.rect(s,(83,46,30),(55,159,146,20),border_radius=8);pygame.image.save(s,sys.argv[1])
