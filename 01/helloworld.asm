
_helloworld:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  11:	83 ec 08             	sub    $0x8,%esp
  14:	68 c8 06 00 00       	push   $0x6c8
  19:	6a 01                	push   $0x1
  1b:	e8 a0 03 00 00       	call   3c0 <printf>
  20:	83 c4 10             	add    $0x10,%esp
  23:	e8 4b 02 00 00       	call   273 <exit>
  28:	66 90                	xchg   %ax,%ax
  2a:	66 90                	xchg   %ax,%ax
  2c:	66 90                	xchg   %ax,%ax
  2e:	66 90                	xchg   %ax,%ax

00000030 <strcpy>:
  30:	55                   	push   %ebp
  31:	31 c0                	xor    %eax,%eax
  33:	89 e5                	mov    %esp,%ebp
  35:	53                   	push   %ebx
  36:	8b 4d 08             	mov    0x8(%ebp),%ecx
  39:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  40:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  44:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  47:	83 c0 01             	add    $0x1,%eax
  4a:	84 d2                	test   %dl,%dl
  4c:	75 f2                	jne    40 <strcpy+0x10>
  4e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  51:	89 c8                	mov    %ecx,%eax
  53:	c9                   	leave
  54:	c3                   	ret
  55:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000060 <strcmp>:
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	53                   	push   %ebx
  64:	8b 55 08             	mov    0x8(%ebp),%edx
  67:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  6a:	0f b6 02             	movzbl (%edx),%eax
  6d:	84 c0                	test   %al,%al
  6f:	75 17                	jne    88 <strcmp+0x28>
  71:	eb 3a                	jmp    ad <strcmp+0x4d>
  73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  77:	90                   	nop
  78:	0f b6 42 01          	movzbl 0x1(%edx),%eax
  7c:	83 c2 01             	add    $0x1,%edx
  7f:	8d 59 01             	lea    0x1(%ecx),%ebx
  82:	84 c0                	test   %al,%al
  84:	74 1a                	je     a0 <strcmp+0x40>
  86:	89 d9                	mov    %ebx,%ecx
  88:	0f b6 19             	movzbl (%ecx),%ebx
  8b:	38 c3                	cmp    %al,%bl
  8d:	74 e9                	je     78 <strcmp+0x18>
  8f:	29 d8                	sub    %ebx,%eax
  91:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  94:	c9                   	leave
  95:	c3                   	ret
  96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  9d:	8d 76 00             	lea    0x0(%esi),%esi
  a0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  a4:	31 c0                	xor    %eax,%eax
  a6:	29 d8                	sub    %ebx,%eax
  a8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  ab:	c9                   	leave
  ac:	c3                   	ret
  ad:	0f b6 19             	movzbl (%ecx),%ebx
  b0:	31 c0                	xor    %eax,%eax
  b2:	eb db                	jmp    8f <strcmp+0x2f>
  b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bf:	90                   	nop

000000c0 <strlen>:
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	8b 55 08             	mov    0x8(%ebp),%edx
  c6:	80 3a 00             	cmpb   $0x0,(%edx)
  c9:	74 15                	je     e0 <strlen+0x20>
  cb:	31 c0                	xor    %eax,%eax
  cd:	8d 76 00             	lea    0x0(%esi),%esi
  d0:	83 c0 01             	add    $0x1,%eax
  d3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  d7:	89 c1                	mov    %eax,%ecx
  d9:	75 f5                	jne    d0 <strlen+0x10>
  db:	89 c8                	mov    %ecx,%eax
  dd:	5d                   	pop    %ebp
  de:	c3                   	ret
  df:	90                   	nop
  e0:	31 c9                	xor    %ecx,%ecx
  e2:	5d                   	pop    %ebp
  e3:	89 c8                	mov    %ecx,%eax
  e5:	c3                   	ret
  e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ed:	8d 76 00             	lea    0x0(%esi),%esi

000000f0 <memset>:
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	57                   	push   %edi
  f4:	8b 55 08             	mov    0x8(%ebp),%edx
  f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  fd:	89 d7                	mov    %edx,%edi
  ff:	fc                   	cld
 100:	f3 aa                	rep stos %al,%es:(%edi)
 102:	8b 7d fc             	mov    -0x4(%ebp),%edi
 105:	89 d0                	mov    %edx,%eax
 107:	c9                   	leave
 108:	c3                   	ret
 109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000110 <strchr>:
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	8b 45 08             	mov    0x8(%ebp),%eax
 116:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
 11a:	0f b6 10             	movzbl (%eax),%edx
 11d:	84 d2                	test   %dl,%dl
 11f:	75 12                	jne    133 <strchr+0x23>
 121:	eb 1d                	jmp    140 <strchr+0x30>
 123:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 127:	90                   	nop
 128:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 12c:	83 c0 01             	add    $0x1,%eax
 12f:	84 d2                	test   %dl,%dl
 131:	74 0d                	je     140 <strchr+0x30>
 133:	38 d1                	cmp    %dl,%cl
 135:	75 f1                	jne    128 <strchr+0x18>
 137:	5d                   	pop    %ebp
 138:	c3                   	ret
 139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 140:	31 c0                	xor    %eax,%eax
 142:	5d                   	pop    %ebp
 143:	c3                   	ret
 144:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 14b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 14f:	90                   	nop

00000150 <gets>:
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	57                   	push   %edi
 154:	56                   	push   %esi
 155:	8d 75 e7             	lea    -0x19(%ebp),%esi
 158:	53                   	push   %ebx
 159:	31 db                	xor    %ebx,%ebx
 15b:	83 ec 1c             	sub    $0x1c,%esp
 15e:	eb 27                	jmp    187 <gets+0x37>
 160:	83 ec 04             	sub    $0x4,%esp
 163:	6a 01                	push   $0x1
 165:	56                   	push   %esi
 166:	6a 00                	push   $0x0
 168:	e8 1e 01 00 00       	call   28b <read>
 16d:	83 c4 10             	add    $0x10,%esp
 170:	85 c0                	test   %eax,%eax
 172:	7e 1d                	jle    191 <gets+0x41>
 174:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 178:	8b 55 08             	mov    0x8(%ebp),%edx
 17b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
 17f:	3c 0a                	cmp    $0xa,%al
 181:	74 10                	je     193 <gets+0x43>
 183:	3c 0d                	cmp    $0xd,%al
 185:	74 0c                	je     193 <gets+0x43>
 187:	89 df                	mov    %ebx,%edi
 189:	83 c3 01             	add    $0x1,%ebx
 18c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 18f:	7c cf                	jl     160 <gets+0x10>
 191:	89 fb                	mov    %edi,%ebx
 193:	8b 45 08             	mov    0x8(%ebp),%eax
 196:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
 19a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 19d:	5b                   	pop    %ebx
 19e:	5e                   	pop    %esi
 19f:	5f                   	pop    %edi
 1a0:	5d                   	pop    %ebp
 1a1:	c3                   	ret
 1a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001b0 <stat>:
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	56                   	push   %esi
 1b4:	53                   	push   %ebx
 1b5:	83 ec 08             	sub    $0x8,%esp
 1b8:	6a 00                	push   $0x0
 1ba:	ff 75 08             	push   0x8(%ebp)
 1bd:	e8 f1 00 00 00       	call   2b3 <open>
 1c2:	83 c4 10             	add    $0x10,%esp
 1c5:	85 c0                	test   %eax,%eax
 1c7:	78 27                	js     1f0 <stat+0x40>
 1c9:	83 ec 08             	sub    $0x8,%esp
 1cc:	ff 75 0c             	push   0xc(%ebp)
 1cf:	89 c3                	mov    %eax,%ebx
 1d1:	50                   	push   %eax
 1d2:	e8 f4 00 00 00       	call   2cb <fstat>
 1d7:	89 1c 24             	mov    %ebx,(%esp)
 1da:	89 c6                	mov    %eax,%esi
 1dc:	e8 ba 00 00 00       	call   29b <close>
 1e1:	83 c4 10             	add    $0x10,%esp
 1e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1e7:	89 f0                	mov    %esi,%eax
 1e9:	5b                   	pop    %ebx
 1ea:	5e                   	pop    %esi
 1eb:	5d                   	pop    %ebp
 1ec:	c3                   	ret
 1ed:	8d 76 00             	lea    0x0(%esi),%esi
 1f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1f5:	eb ed                	jmp    1e4 <stat+0x34>
 1f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1fe:	66 90                	xchg   %ax,%ax

00000200 <atoi>:
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	53                   	push   %ebx
 204:	8b 55 08             	mov    0x8(%ebp),%edx
 207:	0f be 02             	movsbl (%edx),%eax
 20a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 20d:	80 f9 09             	cmp    $0x9,%cl
 210:	b9 00 00 00 00       	mov    $0x0,%ecx
 215:	77 1e                	ja     235 <atoi+0x35>
 217:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 21e:	66 90                	xchg   %ax,%ax
 220:	83 c2 01             	add    $0x1,%edx
 223:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 226:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
 22a:	0f be 02             	movsbl (%edx),%eax
 22d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 230:	80 fb 09             	cmp    $0x9,%bl
 233:	76 eb                	jbe    220 <atoi+0x20>
 235:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 238:	89 c8                	mov    %ecx,%eax
 23a:	c9                   	leave
 23b:	c3                   	ret
 23c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000240 <memmove>:
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	8b 45 10             	mov    0x10(%ebp),%eax
 247:	8b 55 08             	mov    0x8(%ebp),%edx
 24a:	56                   	push   %esi
 24b:	8b 75 0c             	mov    0xc(%ebp),%esi
 24e:	85 c0                	test   %eax,%eax
 250:	7e 13                	jle    265 <memmove+0x25>
 252:	01 d0                	add    %edx,%eax
 254:	89 d7                	mov    %edx,%edi
 256:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 25d:	8d 76 00             	lea    0x0(%esi),%esi
 260:	a4                   	movsb  %ds:(%esi),%es:(%edi)
 261:	39 f8                	cmp    %edi,%eax
 263:	75 fb                	jne    260 <memmove+0x20>
 265:	5e                   	pop    %esi
 266:	89 d0                	mov    %edx,%eax
 268:	5f                   	pop    %edi
 269:	5d                   	pop    %ebp
 26a:	c3                   	ret

0000026b <fork>:
 26b:	b8 01 00 00 00       	mov    $0x1,%eax
 270:	cd 40                	int    $0x40
 272:	c3                   	ret

00000273 <exit>:
 273:	b8 02 00 00 00       	mov    $0x2,%eax
 278:	cd 40                	int    $0x40
 27a:	c3                   	ret

0000027b <wait>:
 27b:	b8 03 00 00 00       	mov    $0x3,%eax
 280:	cd 40                	int    $0x40
 282:	c3                   	ret

00000283 <pipe>:
 283:	b8 04 00 00 00       	mov    $0x4,%eax
 288:	cd 40                	int    $0x40
 28a:	c3                   	ret

0000028b <read>:
 28b:	b8 05 00 00 00       	mov    $0x5,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret

00000293 <write>:
 293:	b8 10 00 00 00       	mov    $0x10,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret

0000029b <close>:
 29b:	b8 15 00 00 00       	mov    $0x15,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret

000002a3 <kill>:
 2a3:	b8 06 00 00 00       	mov    $0x6,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret

000002ab <exec>:
 2ab:	b8 07 00 00 00       	mov    $0x7,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret

000002b3 <open>:
 2b3:	b8 0f 00 00 00       	mov    $0xf,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret

000002bb <mknod>:
 2bb:	b8 11 00 00 00       	mov    $0x11,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret

000002c3 <unlink>:
 2c3:	b8 12 00 00 00       	mov    $0x12,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret

000002cb <fstat>:
 2cb:	b8 08 00 00 00       	mov    $0x8,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret

000002d3 <link>:
 2d3:	b8 13 00 00 00       	mov    $0x13,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret

000002db <mkdir>:
 2db:	b8 14 00 00 00       	mov    $0x14,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret

000002e3 <chdir>:
 2e3:	b8 09 00 00 00       	mov    $0x9,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret

000002eb <dup>:
 2eb:	b8 0a 00 00 00       	mov    $0xa,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret

000002f3 <getpid>:
 2f3:	b8 0b 00 00 00       	mov    $0xb,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret

000002fb <sbrk>:
 2fb:	b8 0c 00 00 00       	mov    $0xc,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret

00000303 <sleep>:
 303:	b8 0d 00 00 00       	mov    $0xd,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret

0000030b <uptime>:
 30b:	b8 0e 00 00 00       	mov    $0xe,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret
 313:	66 90                	xchg   %ax,%ax
 315:	66 90                	xchg   %ax,%ax
 317:	66 90                	xchg   %ax,%ax
 319:	66 90                	xchg   %ax,%ax
 31b:	66 90                	xchg   %ax,%ax
 31d:	66 90                	xchg   %ax,%ax
 31f:	90                   	nop

00000320 <printint>:
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	57                   	push   %edi
 324:	56                   	push   %esi
 325:	53                   	push   %ebx
 326:	89 cb                	mov    %ecx,%ebx
 328:	89 d1                	mov    %edx,%ecx
 32a:	83 ec 3c             	sub    $0x3c,%esp
 32d:	89 45 c0             	mov    %eax,-0x40(%ebp)
 330:	85 d2                	test   %edx,%edx
 332:	0f 89 80 00 00 00    	jns    3b8 <printint+0x98>
 338:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 33c:	74 7a                	je     3b8 <printint+0x98>
 33e:	f7 d9                	neg    %ecx
 340:	b8 01 00 00 00       	mov    $0x1,%eax
 345:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 348:	31 f6                	xor    %esi,%esi
 34a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 350:	89 c8                	mov    %ecx,%eax
 352:	31 d2                	xor    %edx,%edx
 354:	89 f7                	mov    %esi,%edi
 356:	f7 f3                	div    %ebx
 358:	8d 76 01             	lea    0x1(%esi),%esi
 35b:	0f b6 92 34 07 00 00 	movzbl 0x734(%edx),%edx
 362:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
 366:	89 ca                	mov    %ecx,%edx
 368:	89 c1                	mov    %eax,%ecx
 36a:	39 da                	cmp    %ebx,%edx
 36c:	73 e2                	jae    350 <printint+0x30>
 36e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 371:	85 c0                	test   %eax,%eax
 373:	74 07                	je     37c <printint+0x5c>
 375:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 37a:	89 f7                	mov    %esi,%edi
 37c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 37f:	8b 75 c0             	mov    -0x40(%ebp),%esi
 382:	01 df                	add    %ebx,%edi
 384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 388:	0f b6 07             	movzbl (%edi),%eax
 38b:	83 ec 04             	sub    $0x4,%esp
 38e:	88 45 d7             	mov    %al,-0x29(%ebp)
 391:	8d 45 d7             	lea    -0x29(%ebp),%eax
 394:	6a 01                	push   $0x1
 396:	50                   	push   %eax
 397:	56                   	push   %esi
 398:	e8 f6 fe ff ff       	call   293 <write>
 39d:	89 f8                	mov    %edi,%eax
 39f:	83 c4 10             	add    $0x10,%esp
 3a2:	83 ef 01             	sub    $0x1,%edi
 3a5:	39 c3                	cmp    %eax,%ebx
 3a7:	75 df                	jne    388 <printint+0x68>
 3a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3ac:	5b                   	pop    %ebx
 3ad:	5e                   	pop    %esi
 3ae:	5f                   	pop    %edi
 3af:	5d                   	pop    %ebp
 3b0:	c3                   	ret
 3b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3b8:	31 c0                	xor    %eax,%eax
 3ba:	eb 89                	jmp    345 <printint+0x25>
 3bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003c0 <printf>:
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	57                   	push   %edi
 3c4:	56                   	push   %esi
 3c5:	53                   	push   %ebx
 3c6:	83 ec 2c             	sub    $0x2c,%esp
 3c9:	8b 75 0c             	mov    0xc(%ebp),%esi
 3cc:	8b 7d 08             	mov    0x8(%ebp),%edi
 3cf:	0f b6 1e             	movzbl (%esi),%ebx
 3d2:	83 c6 01             	add    $0x1,%esi
 3d5:	84 db                	test   %bl,%bl
 3d7:	74 67                	je     440 <printf+0x80>
 3d9:	8d 4d 10             	lea    0x10(%ebp),%ecx
 3dc:	31 d2                	xor    %edx,%edx
 3de:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 3e1:	eb 34                	jmp    417 <printf+0x57>
 3e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3e7:	90                   	nop
 3e8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 3eb:	ba 25 00 00 00       	mov    $0x25,%edx
 3f0:	83 f8 25             	cmp    $0x25,%eax
 3f3:	74 18                	je     40d <printf+0x4d>
 3f5:	83 ec 04             	sub    $0x4,%esp
 3f8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3fb:	88 5d e7             	mov    %bl,-0x19(%ebp)
 3fe:	6a 01                	push   $0x1
 400:	50                   	push   %eax
 401:	57                   	push   %edi
 402:	e8 8c fe ff ff       	call   293 <write>
 407:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 40a:	83 c4 10             	add    $0x10,%esp
 40d:	0f b6 1e             	movzbl (%esi),%ebx
 410:	83 c6 01             	add    $0x1,%esi
 413:	84 db                	test   %bl,%bl
 415:	74 29                	je     440 <printf+0x80>
 417:	0f b6 c3             	movzbl %bl,%eax
 41a:	85 d2                	test   %edx,%edx
 41c:	74 ca                	je     3e8 <printf+0x28>
 41e:	83 fa 25             	cmp    $0x25,%edx
 421:	75 ea                	jne    40d <printf+0x4d>
 423:	83 f8 25             	cmp    $0x25,%eax
 426:	0f 84 04 01 00 00    	je     530 <printf+0x170>
 42c:	83 e8 63             	sub    $0x63,%eax
 42f:	83 f8 15             	cmp    $0x15,%eax
 432:	77 1c                	ja     450 <printf+0x90>
 434:	ff 24 85 dc 06 00 00 	jmp    *0x6dc(,%eax,4)
 43b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 43f:	90                   	nop
 440:	8d 65 f4             	lea    -0xc(%ebp),%esp
 443:	5b                   	pop    %ebx
 444:	5e                   	pop    %esi
 445:	5f                   	pop    %edi
 446:	5d                   	pop    %ebp
 447:	c3                   	ret
 448:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 44f:	90                   	nop
 450:	83 ec 04             	sub    $0x4,%esp
 453:	8d 55 e7             	lea    -0x19(%ebp),%edx
 456:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 45a:	6a 01                	push   $0x1
 45c:	52                   	push   %edx
 45d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 460:	57                   	push   %edi
 461:	e8 2d fe ff ff       	call   293 <write>
 466:	83 c4 0c             	add    $0xc,%esp
 469:	88 5d e7             	mov    %bl,-0x19(%ebp)
 46c:	6a 01                	push   $0x1
 46e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 471:	52                   	push   %edx
 472:	57                   	push   %edi
 473:	e8 1b fe ff ff       	call   293 <write>
 478:	83 c4 10             	add    $0x10,%esp
 47b:	31 d2                	xor    %edx,%edx
 47d:	eb 8e                	jmp    40d <printf+0x4d>
 47f:	90                   	nop
 480:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 483:	83 ec 0c             	sub    $0xc,%esp
 486:	b9 10 00 00 00       	mov    $0x10,%ecx
 48b:	8b 13                	mov    (%ebx),%edx
 48d:	6a 00                	push   $0x0
 48f:	89 f8                	mov    %edi,%eax
 491:	83 c3 04             	add    $0x4,%ebx
 494:	e8 87 fe ff ff       	call   320 <printint>
 499:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 49c:	83 c4 10             	add    $0x10,%esp
 49f:	31 d2                	xor    %edx,%edx
 4a1:	e9 67 ff ff ff       	jmp    40d <printf+0x4d>
 4a6:	8b 45 d0             	mov    -0x30(%ebp),%eax
 4a9:	8b 18                	mov    (%eax),%ebx
 4ab:	83 c0 04             	add    $0x4,%eax
 4ae:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4b1:	85 db                	test   %ebx,%ebx
 4b3:	0f 84 87 00 00 00    	je     540 <printf+0x180>
 4b9:	0f b6 03             	movzbl (%ebx),%eax
 4bc:	31 d2                	xor    %edx,%edx
 4be:	84 c0                	test   %al,%al
 4c0:	0f 84 47 ff ff ff    	je     40d <printf+0x4d>
 4c6:	8d 55 e7             	lea    -0x19(%ebp),%edx
 4c9:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 4cc:	89 de                	mov    %ebx,%esi
 4ce:	89 d3                	mov    %edx,%ebx
 4d0:	83 ec 04             	sub    $0x4,%esp
 4d3:	88 45 e7             	mov    %al,-0x19(%ebp)
 4d6:	83 c6 01             	add    $0x1,%esi
 4d9:	6a 01                	push   $0x1
 4db:	53                   	push   %ebx
 4dc:	57                   	push   %edi
 4dd:	e8 b1 fd ff ff       	call   293 <write>
 4e2:	0f b6 06             	movzbl (%esi),%eax
 4e5:	83 c4 10             	add    $0x10,%esp
 4e8:	84 c0                	test   %al,%al
 4ea:	75 e4                	jne    4d0 <printf+0x110>
 4ec:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 4ef:	31 d2                	xor    %edx,%edx
 4f1:	e9 17 ff ff ff       	jmp    40d <printf+0x4d>
 4f6:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 4f9:	83 ec 0c             	sub    $0xc,%esp
 4fc:	b9 0a 00 00 00       	mov    $0xa,%ecx
 501:	8b 13                	mov    (%ebx),%edx
 503:	6a 01                	push   $0x1
 505:	eb 88                	jmp    48f <printf+0xcf>
 507:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 50a:	83 ec 04             	sub    $0x4,%esp
 50d:	8d 55 e7             	lea    -0x19(%ebp),%edx
 510:	8b 03                	mov    (%ebx),%eax
 512:	83 c3 04             	add    $0x4,%ebx
 515:	88 45 e7             	mov    %al,-0x19(%ebp)
 518:	6a 01                	push   $0x1
 51a:	52                   	push   %edx
 51b:	57                   	push   %edi
 51c:	e8 72 fd ff ff       	call   293 <write>
 521:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 524:	83 c4 10             	add    $0x10,%esp
 527:	31 d2                	xor    %edx,%edx
 529:	e9 df fe ff ff       	jmp    40d <printf+0x4d>
 52e:	66 90                	xchg   %ax,%ax
 530:	83 ec 04             	sub    $0x4,%esp
 533:	88 5d e7             	mov    %bl,-0x19(%ebp)
 536:	8d 55 e7             	lea    -0x19(%ebp),%edx
 539:	6a 01                	push   $0x1
 53b:	e9 31 ff ff ff       	jmp    471 <printf+0xb1>
 540:	b8 28 00 00 00       	mov    $0x28,%eax
 545:	bb d5 06 00 00       	mov    $0x6d5,%ebx
 54a:	e9 77 ff ff ff       	jmp    4c6 <printf+0x106>
 54f:	90                   	nop

00000550 <free>:
 550:	55                   	push   %ebp
 551:	a1 48 07 00 00       	mov    0x748,%eax
 556:	89 e5                	mov    %esp,%ebp
 558:	57                   	push   %edi
 559:	56                   	push   %esi
 55a:	53                   	push   %ebx
 55b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 55e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 561:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 568:	8b 10                	mov    (%eax),%edx
 56a:	39 c8                	cmp    %ecx,%eax
 56c:	73 32                	jae    5a0 <free+0x50>
 56e:	39 d1                	cmp    %edx,%ecx
 570:	72 04                	jb     576 <free+0x26>
 572:	39 d0                	cmp    %edx,%eax
 574:	72 32                	jb     5a8 <free+0x58>
 576:	8b 73 fc             	mov    -0x4(%ebx),%esi
 579:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 57c:	39 fa                	cmp    %edi,%edx
 57e:	74 30                	je     5b0 <free+0x60>
 580:	89 53 f8             	mov    %edx,-0x8(%ebx)
 583:	8b 50 04             	mov    0x4(%eax),%edx
 586:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 589:	39 f1                	cmp    %esi,%ecx
 58b:	74 3a                	je     5c7 <free+0x77>
 58d:	89 08                	mov    %ecx,(%eax)
 58f:	5b                   	pop    %ebx
 590:	a3 48 07 00 00       	mov    %eax,0x748
 595:	5e                   	pop    %esi
 596:	5f                   	pop    %edi
 597:	5d                   	pop    %ebp
 598:	c3                   	ret
 599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5a0:	39 d0                	cmp    %edx,%eax
 5a2:	72 04                	jb     5a8 <free+0x58>
 5a4:	39 d1                	cmp    %edx,%ecx
 5a6:	72 ce                	jb     576 <free+0x26>
 5a8:	89 d0                	mov    %edx,%eax
 5aa:	eb bc                	jmp    568 <free+0x18>
 5ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5b0:	03 72 04             	add    0x4(%edx),%esi
 5b3:	89 73 fc             	mov    %esi,-0x4(%ebx)
 5b6:	8b 10                	mov    (%eax),%edx
 5b8:	8b 12                	mov    (%edx),%edx
 5ba:	89 53 f8             	mov    %edx,-0x8(%ebx)
 5bd:	8b 50 04             	mov    0x4(%eax),%edx
 5c0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5c3:	39 f1                	cmp    %esi,%ecx
 5c5:	75 c6                	jne    58d <free+0x3d>
 5c7:	03 53 fc             	add    -0x4(%ebx),%edx
 5ca:	a3 48 07 00 00       	mov    %eax,0x748
 5cf:	89 50 04             	mov    %edx,0x4(%eax)
 5d2:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 5d5:	89 08                	mov    %ecx,(%eax)
 5d7:	5b                   	pop    %ebx
 5d8:	5e                   	pop    %esi
 5d9:	5f                   	pop    %edi
 5da:	5d                   	pop    %ebp
 5db:	c3                   	ret
 5dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000005e0 <malloc>:
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	57                   	push   %edi
 5e4:	56                   	push   %esi
 5e5:	53                   	push   %ebx
 5e6:	83 ec 0c             	sub    $0xc,%esp
 5e9:	8b 45 08             	mov    0x8(%ebp),%eax
 5ec:	8b 15 48 07 00 00    	mov    0x748,%edx
 5f2:	8d 78 07             	lea    0x7(%eax),%edi
 5f5:	c1 ef 03             	shr    $0x3,%edi
 5f8:	83 c7 01             	add    $0x1,%edi
 5fb:	85 d2                	test   %edx,%edx
 5fd:	0f 84 8d 00 00 00    	je     690 <malloc+0xb0>
 603:	8b 02                	mov    (%edx),%eax
 605:	8b 48 04             	mov    0x4(%eax),%ecx
 608:	39 f9                	cmp    %edi,%ecx
 60a:	73 64                	jae    670 <malloc+0x90>
 60c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 611:	39 df                	cmp    %ebx,%edi
 613:	0f 43 df             	cmovae %edi,%ebx
 616:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 61d:	eb 0a                	jmp    629 <malloc+0x49>
 61f:	90                   	nop
 620:	8b 02                	mov    (%edx),%eax
 622:	8b 48 04             	mov    0x4(%eax),%ecx
 625:	39 f9                	cmp    %edi,%ecx
 627:	73 47                	jae    670 <malloc+0x90>
 629:	89 c2                	mov    %eax,%edx
 62b:	3b 05 48 07 00 00    	cmp    0x748,%eax
 631:	75 ed                	jne    620 <malloc+0x40>
 633:	83 ec 0c             	sub    $0xc,%esp
 636:	56                   	push   %esi
 637:	e8 bf fc ff ff       	call   2fb <sbrk>
 63c:	83 c4 10             	add    $0x10,%esp
 63f:	83 f8 ff             	cmp    $0xffffffff,%eax
 642:	74 1c                	je     660 <malloc+0x80>
 644:	89 58 04             	mov    %ebx,0x4(%eax)
 647:	83 ec 0c             	sub    $0xc,%esp
 64a:	83 c0 08             	add    $0x8,%eax
 64d:	50                   	push   %eax
 64e:	e8 fd fe ff ff       	call   550 <free>
 653:	8b 15 48 07 00 00    	mov    0x748,%edx
 659:	83 c4 10             	add    $0x10,%esp
 65c:	85 d2                	test   %edx,%edx
 65e:	75 c0                	jne    620 <malloc+0x40>
 660:	8d 65 f4             	lea    -0xc(%ebp),%esp
 663:	31 c0                	xor    %eax,%eax
 665:	5b                   	pop    %ebx
 666:	5e                   	pop    %esi
 667:	5f                   	pop    %edi
 668:	5d                   	pop    %ebp
 669:	c3                   	ret
 66a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 670:	39 cf                	cmp    %ecx,%edi
 672:	74 4c                	je     6c0 <malloc+0xe0>
 674:	29 f9                	sub    %edi,%ecx
 676:	89 48 04             	mov    %ecx,0x4(%eax)
 679:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
 67c:	89 78 04             	mov    %edi,0x4(%eax)
 67f:	89 15 48 07 00 00    	mov    %edx,0x748
 685:	8d 65 f4             	lea    -0xc(%ebp),%esp
 688:	83 c0 08             	add    $0x8,%eax
 68b:	5b                   	pop    %ebx
 68c:	5e                   	pop    %esi
 68d:	5f                   	pop    %edi
 68e:	5d                   	pop    %ebp
 68f:	c3                   	ret
 690:	c7 05 48 07 00 00 4c 	movl   $0x74c,0x748
 697:	07 00 00 
 69a:	b8 4c 07 00 00       	mov    $0x74c,%eax
 69f:	c7 05 4c 07 00 00 4c 	movl   $0x74c,0x74c
 6a6:	07 00 00 
 6a9:	c7 05 50 07 00 00 00 	movl   $0x0,0x750
 6b0:	00 00 00 
 6b3:	e9 54 ff ff ff       	jmp    60c <malloc+0x2c>
 6b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6bf:	90                   	nop
 6c0:	8b 08                	mov    (%eax),%ecx
 6c2:	89 0a                	mov    %ecx,(%edx)
 6c4:	eb b9                	jmp    67f <malloc+0x9f>
