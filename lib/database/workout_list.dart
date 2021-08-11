import 'package:flutter/material.dart';


class Workout {
  String title;
  String imageSrc;
  String videoLink;
  List<String> steps;
  bool showTimer;
  int beginnerRap;
  int intermediateRap;
  int advanceRap;
  int duration;

  Workout({
    @required this.title,
    @required this.imageSrc,
    @required this.steps,
    @required this.videoLink,
    @required this.showTimer,
    this.beginnerRap,
    this.advanceRap,
    this.intermediateRap,
    this.duration,
  });
}
//Arm
Workout armCurlsCrunchLeft = Workout(
  title: 'Arm Curls Crunch Left',
  steps: [
    'Lie on your left side with your knees bent and lifted.',
    'Grasp your left thigh with your left hand and put your right hand behind your head.',
    'Then raise your upper body by pulling your left thigh.',
    'Repeat the exercise.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=pxsOe8MJq68&ab_channel=LeapFitness',
  showTimer: false,
  beginnerRap: 10,
  intermediateRap: 14,
  advanceRap: 18,
  imageSrc: 'assets/all-workouts/armCurlsCrunchLeft.gif',
);
Workout armCurlsCrunchLeft2 = Workout(
  title: 'Arm Curls Crunch Left',
  steps: [
    'Lie on your left side with your knees bent and lifted.',
    'Grasp your left thigh with your left hand and put your right hand behind your head.',
    'Then raise your upper body by pulling your left thigh.',
    'Repeat the exercise.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=pxsOe8MJq68&ab_channel=LeapFitness',
  showTimer: false,
  beginnerRap: 8,
  intermediateRap: 12,
  advanceRap: 14,
  imageSrc: 'assets/all-workouts/armCurlsCrunchLeft.gif',
);
Workout armCurlsCrunchRight = Workout(
    title: 'Arm Curls Crunch Right',
    steps: [
      'Lie on your right side with your knees bent and lifted.',
      'Grasp your right thigh with your right hand and put your left hand behind your head.',
      'Then raise your upper body by pulling your right thigh.',
      'Repeat the exercise.',
    ],
    videoLink:
        'https://www.youtube.com/watch?v=pxsOe8MJq68&ab_channel=LeapFitness',
    showTimer: false,
    beginnerRap: 10,
    intermediateRap: 14,
    advanceRap: 18,
    imageSrc: 'assets/all-workouts/armCurlsCrunchRight.gif');
Workout armCurlsCrunchRight2 = Workout(
    title: 'Arm Curls Crunch Right',
    steps: [
      'Lie on your right side with your knees bent and lifted.',
      'Grasp your right thigh with your right hand and put your left hand behind your head.',
      'Then raise your upper body by pulling your right thigh.',
      'Repeat the exercise.',
    ],
    videoLink:
        'https://www.youtube.com/watch?v=pxsOe8MJq68&ab_channel=LeapFitness',
    showTimer: false,
    beginnerRap: 8,
    intermediateRap: 12,
    advanceRap: 14,
    imageSrc: 'assets/all-workouts/armCurlsCrunchRight.gif');
Workout skippingWithOutRope = Workout(
  title: 'Skipping Without Rope',
  steps: [
    'Stand in a straight position with your feet together and facing forward and hands positioned to look as if holding a rope.',
    'Begin jumping the imaginary rope.',
    'Increase pace and jumping variations such as hopping with one leg.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=bTJW3LUwrOA&ab_channel=HarrisonAndFam',
  showTimer: true,
  duration: 30,
  imageSrc: 'assets/all-workouts/skippignwithout rope.gif',
);
Workout tricepsPushUp = Workout(
  title: 'Triceps Push-ups',
  steps: [
    'Get into a plank position with your hands directly below shoulders, your neck and spine neutral, and your feet together.',
    'On the descent, keep your elbows pinned to your sides and your upper arms straight back.',
    'Lower down until your chest reaches the floor and return to start.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=kZi0j-7rDe8&ab_channel=Well%2BGood',
  showTimer: false,
  beginnerRap: 8,
  intermediateRap: 12,
  advanceRap: 16,
  imageSrc: 'assets/all-workouts/tricepsPushUp.gif',
);
Workout tricepsPushUp2 = Workout(
  title: 'Triceps Push-ups',
  steps: [
    'Get into a plank position with your hands directly below shoulders, your neck and spine neutral, and your feet together.',
    'On the descent, keep your elbows pinned to your sides and your upper arms straight back.',
    'Lower down until your chest reaches the floor and return to start.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=kZi0j-7rDe8&ab_channel=Well%2BGood',
  showTimer: false,
  beginnerRap: 6,
  intermediateRap: 8,
  advanceRap: 12,
  imageSrc: 'assets/all-workouts/tricepsPushUp.gif',
);
Workout armCircleClockWise = Workout(
  title: 'Arm Circle ClockWise',
  steps: [
    'Stand straight up with your arms extended out to each side, parallel to the ground.',
    'Bring your arms slightly forward, upward, and then backward, making 12 inch circles with your arms.',
    'Repeat the circle movement twelve times and then reverse the motion by going backward, upward, and the forward. Repeat that motion twelve times as well.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=140RTNMciH8&ab_channel=FitnessBlender',
  showTimer: true,
  duration: 30,
  imageSrc: 'assets/all-workouts/armCircleClockWIse.gif',
);
Workout armCircleCounterClockWise = Workout(
    title: 'Arm Circle Counterclockwise',
    steps: [
      'Stand on the floor with your arms extended straight out to the sides at shoulder height',
      'Move your arms counterclockwise in circles fast',
      'Try to do it as fast as you can Its a great exercise for the deltoid muscle',
    ],
    videoLink:
        'https://www.youtube.com/watch?v=140RTNMciH8&ab_channel=FitnessBlender',
    showTimer: true,
    duration: 30,
    imageSrc: 'assets/all-workouts/armCircleCounterClock.gif');
Workout diagonalPlank = Workout(
    title: 'Diagonal Plank',
    steps: [
      'Start in the straight arm plank position',
      'Lift your right arm and left leg until they are parallel with the ground',
      'Return to the start position and repeat with the other side',
    ],
    videoLink:
        'https://www.youtube.com/watch?v=lsoQDZkmQ0c&ab_channel=BrianAganad',
    showTimer: false,
    beginnerRap: 10,
    intermediateRap: 14,
    advanceRap: 18,
    imageSrc: 'assets/all-workouts/diagonalPlank.gif');
Workout punches = Workout(
  title: 'Punches',
  steps: [
    'Stand with your feet hip-width apart, your knees slightly bent.',
    'Take a step forward with your left foot, keep your back foot at a 45-degree angle and position your body partially sideways.',
    'Bring your arms up, so that the palms of the hands are facing the sides of the face.',
    'Push your right arm out in a punching motion and then return to the starting position.',
    'Switch sides and repeat.',
  ],
  videoLink: 'https://www.youtube.com/watch?v=M_4Vt5lfEUE&ab_channel=DAREBEE',
  showTimer: false,
  beginnerRap: 10,
  intermediateRap: 14,
  advanceRap: 18,
  imageSrc: 'assets/all-workouts/punches.gif',
);
Workout punches2 = Workout(
  title: 'Punches',
  steps: [
    'Stand with your feet hip-width apart, your knees slightly bent.',
    'Take a step forward with your left foot, keep your back foot at a 45-degree angle and position your body partially sideways.',
    'Bring your arms up, so that the palms of the hands are facing the sides of the face.',
    'Push your right arm out in a punching motion and then return to the starting position.',
    'Switch sides and repeat.',
  ],
  videoLink: 'https://www.youtube.com/watch?v=M_4Vt5lfEUE&ab_channel=DAREBEE',
  showTimer: false,
  beginnerRap: 8,
  intermediateRap: 12,
  advanceRap: 16,
  imageSrc: 'assets/all-workouts/punches.gif',
);
Workout wallPushUps = Workout(
  title: 'Wall Push-Ups',
  steps: [
    'Assume the starting position with feet and legs together, standing about 2 feet from a wall with your arms straight out in front of you.',
    'Your palms should be on the wall at about shoulder-level height and shoulder-width apart, with finger pointed toward the ceiling.',
    'If you feel like you’re reaching too far, move your feet closer.',
    'Bend your elbows and begin to lean your body toward the wall until your nose almost touches it. Ensure your back stays straight and your hips don’t sag.',
    'Push back to the starting position and repeat.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=YB0egDzsu18&ab_channel=StylecrazeFitness',
  showTimer: false,
  beginnerRap: 10,
  intermediateRap: 14,
  advanceRap: 18,
  imageSrc: 'assets/all-workouts/wallPushUps.gif',
);
Workout tricepsStretchLeft = Workout(
    title: 'Triceps Stretch Left',
    steps: [
      'Standing up straight with a tight core, extend your left arm straight into the air.',
      'Keep the elbow up as you bend your arm behind your head.',
      'Take the right hand and gently pull the left elbow towards the right.',
    ],
    videoLink: 'https://youtu.be/nbHOmIYMazk',
    showTimer: true,
    duration: 30,
    imageSrc: 'assets/all-workouts/tricepsStretchLeft.gif');
Workout tricepsStretchRight = Workout(
  title: 'Triceps Stretch Right',
  steps: [
    'Standing up straight with a tight core , extend your',
    'right arm straight into the air.',
    'Keep the elbow up as you bend your arm behind your head.',
    'Take the right hand and gently pull the left elbow towards the right.',
  ],
  videoLink: 'https://youtu.be/nbHOmIYMazk',
  showTimer: true,
  duration: 30,
  imageSrc: 'assets/all-workouts/tricepsStretchRight.gif',
);
Workout standingBicepsStretchRight = Workout(
    title: 'Standing Biceps Stretch Right',
    steps: [
      'Stand with your right arm close to a wall.',
      'Extend your right arm and put your body right hand on the wall.',
      'Then gently turn your body to the right.',
    ],
    videoLink: 'https://youtu.be/QY4gCIYbGQk',
    showTimer: true,
    duration: 30,
    imageSrc: 'assets/all-workouts/standingBicepsStrechRight.png');
Workout standingBicepsStretchLeft = Workout(
    title: 'Standing Biceps Stretch Left',
    steps: [
      'Stand with your left arm close to a wall.',
      'Extend your left arm and put your body left hand on the wall.',
      'Then gently turn your body to the right.',
    ],
    videoLink: 'https://youtu.be/QY4gCIYbGQk',
    showTimer: true,
    duration: 30,
    imageSrc: 'assets/all-workouts/standingBicepsStrechLeft.png');
//Legs
Workout kneeToChestStretch = Workout(
  title: 'Knee Hugs',
  steps: [
    'Stand with your feet shoulder-width apart. Maintain a tight core throughout.',
    'Lift your left knee up and towards your chest.',
    'Grab your left knee and pull it in as close as you can into your chest.',
    'Slowly release the left leg to the ground and repeat on the other side.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=lw--mordTFw&ab_channel=YSTExercises',
  showTimer: true,
  duration: 20,
  imageSrc: 'assets/all-workouts/kneeToChestStretch.gif',
);
Workout squats = Workout(
  title: 'Squats',
  steps: [
    'Stand with feet a little wider than hip width, toes facing front.',
    'Drive your hips back—bending at the knees and ankles and pressing your knees slightly open—as you.',
    'Sit into a squat position while still keeping your heels and toes on the ground, chest up and shoulders back.',
    'Strive to eventually reach parallel, meaning knees are bent to a 90-degree angle.',
    'Press into your heels and straighten legs to return to a standing upright position.',
  ],
  videoLink: 'https://www.youtube.com/watch?v=aclHkVaku9U&ab_channel=Bowflex',
  showTimer: false,
  beginnerRap: 12,
  intermediateRap: 14,
  imageSrc: "assets/all-workouts/squats.gif",
);
Workout buttBridge = Workout(
  title: 'Butt Bridge',
  steps: [
    'Lie on your back with your hands at your sides, knees bent, and feet flat on the floor under your knees.',
    'Tighten your abdominal and buttock muscles by pushing your low back into the ground before you push up.',
    'Raise your hips to create a straight line from your knees to shoulders.',
    'Squeeze your core and pull your belly button back toward your spine.',
    'Hold for 20 to 30 seconds, and then return to your starting position.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=wPM8icPu6H8&ab_channel=Well%2BGood',
  showTimer: false,
  intermediateRap: 12,
  imageSrc: 'assets/all-workouts/buttBridge.gif',
);
Workout curtsyLunges = Workout(
  title: 'Curtsy Lunges',
  steps: [
    'Stand with your feet hip-distance apart and let your arms fall at your sides.',
    'Draw a semicircle with your right foot, moving it clockwise until it crosses behind your left foot.',
    'Keep your right toe tucked and clasp your hands together at your heart.',
    'Lunge down as deeply as possible, hovering your knee a couple of inches off the floor.',
    'Slowly return to the standing curtsy position.',
    'Repeat the lunge on the other side.'
  ],
  videoLink:
      'https://www.youtube.com/watch?v=Ix_SFZVDy0I&ab_channel=Tone%26Sculpt',
  showTimer: false,
  advanceRap: 16,
  imageSrc: 'assets/all-workouts/curtsyLunges.gif',
);
Workout bottomLegLiftLeft = Workout(
  title: 'Bottom Leg Lift Left',
  steps: [
    'Lift your ribs and prop your head up on your hand. Be sure that you keep your back and neck in good alignment.',
    'Bring the foot of your top leg up to rest in front of your hips.',
    'Thread your top hand behind the calf and grasp the outside of your ankle.',
    'Inhale, and reach the bottom leg long, lifting it up off the floor. Keep it straight as you lift.',
    'Exhale and maintain that sense of length as you lower the leg back down.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=upsdqLsXvSY&ab_channel=FastpitchPower',
  showTimer: false,
  advanceRap: 16,
  beginnerRap: 10,
  intermediateRap: 12,
  imageSrc: 'assets/all-workouts/bottomLegLift_L.gif',
);
Workout bottomLegLiftRight = Workout(
    title: 'Bottom Leg Lift Right',
    steps: [
      'Lift your ribs and prop your head up on your hand. Be sure that you keep your back and neck in good alignment.',
      'Bring the foot of your top leg up to rest in front of your hips.',
      'Thread your top hand behind the calf and grasp the outside of your ankle.',
      'Inhale, and reach the bottom leg long, lifting it up off the floor. Keep it straight as you lift.',
      'Exhale and maintain that sense of length as you lower the leg back down.',
    ],
    videoLink:
        'https://www.youtube.com/watch?v=upsdqLsXvSY&ab_channel=FastpitchPower',
    showTimer: false,
    advanceRap: 16,
    beginnerRap: 10,
    intermediateRap: 12,
    imageSrc: 'assets/all-workouts/bottomLegLift_R.gif');
Workout sumoSquat = Workout(
  title: 'Sumo Squat',
  steps: [
    'Stand with your feet slightly wider than hip-width apart and turn your feet out, externally rotating your hips.',
    'With your hands clasped together at your chest, push your hips back and squat down.',
    'Keeping your back straight and your upper body lifted.',
    'Make sure you’re pushing through your heels and engaging your inner thighs as you come back to your starting position.',
  ],
  videoLink: 'https://youtu.be/kjlfpqXnyL8',
  showTimer: false,
  advanceRap: 16,
  beginnerRap: 12,
  intermediateRap: 14,
  imageSrc: 'assets/all-workouts/sumoSquat.gif',
);
Workout fireHydrantLeft = Workout(
  title: 'Fire Hydrant Left',
  steps: [
    'Start on your hands and knees. Place your shoulders above your hands and your hips above your knees. Tighten your core and look down.',
    'Lift your left leg away from your body at a 45-degree angle. Keep your knee at 90 degrees.',
    'Lower your leg to starting position to complete 1 rep.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=ZVfcRHhcBgg&feature=emb_logo&ab_channel=Children%27sHospitalColorado',
  showTimer: false,
  advanceRap: 16,
  intermediateRap: 12,
  beginnerRap: 10,
  imageSrc: 'assets/all-workouts/fire_hydrant_L.gif',
);
Workout fireHydrantRight = Workout(
  title: 'Fire Hydrant Right',
  steps: [
    'Start on your hands and knees. Place your shoulders above your hands and your hips above your knees. Tighten your core and look down.',
    'Lift your left leg away from your body at a 45-degree angle. Keep your knee at 90 degrees.',
    'Lower your leg to starting position to complete 1 rep.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=ZVfcRHhcBgg&feature=emb_logo&ab_channel=Children%27sHospitalColorado',
  showTimer: false,
  advanceRap: 16,
  intermediateRap: 12,
  beginnerRap: 10,
  imageSrc: 'assets/all-workouts/fire_hydrant_R.gif',
);
Workout jumpingSquats = Workout(
  title: 'Jumping Squats',
  steps: [
    'Stand with your feet shoulder-width apart.',
    'Start by doing a regular squat, engage your core, and jump up explosively.',
    'When you land, lower your body back into the squat position to complete one rep.',
    'Make sure you land with your entire foot on the ground.',
    'Be sure to land as quietly as possible, which requires control.',
  ],
  videoLink: 'https://www.youtube.com/watch?v=eUl1Ttx8b98&ab_channel=Howcast',
  showTimer: false,
  advanceRap: 14,
  imageSrc: 'assets/all-workouts/jumpingSquats.gif',
);
Workout wallSit = Workout(
    title: 'Wall Sit',
    steps: [
      'Make sure your back is flat against the wall.',
      'Place your feet firmly on the ground, shoulder-width apart, and then about 2 feet out from the wall.',
      'Slide your back down the wall while keeping your core engaged and bending your legs until',
      'HOLD your position, while contracting your ab muscles.',
      'When you’re ready to wrap it up, take a few seconds to slowly come back to a standing position while leaning against the wall.',
    ],
    videoLink:
        'https://www.youtube.com/watch?v=-cdph8hv0O0&ab_channel=FitnessBlender',
    showTimer: true,
    duration: 30,
    imageSrc: 'assets/all-workouts/wallUp.gif');
Workout leftQuadStretch = Workout(
  title: 'Left Quad Stretch',
  steps: [
    'Stand up tall and shift your weight to the right leg.',
    'Lift your left foot and grasp with your left hand.',
    'Pull the left foot toward your butt until you feel the stretch in your quads.'
  ],
  videoLink: 'https://www.youtube.com/watch?v=vPo1j-fzfNo&ab_channel=Howcast',
  showTimer: true,
  duration: 30,
  imageSrc: 'assets/all-workouts/quadStretchWithWallLeft.png',
);
Workout rightQuadStretch = Workout(
  title: 'Right Quad Stretch',
  steps: [
    'Stand up tall and shift your weight to the left leg.',
    'Lift your right foot and grasp with your right hand.',
    'Pull the right foot toward your butt until you feel the stretch in your quads.',
  ],
  videoLink: 'https://www.youtube.com/watch?v=vPo1j-fzfNo&ab_channel=Howcast',
  showTimer: true,
  duration: 30,
  imageSrc: 'assets/all-workouts/quadStretchWithWallRight.png',
);
Workout wallResistingSingleLegLeft = Workout(
  title: 'Wall Resisting Single Leg Left',
  steps: [
    'Stand tall facing a wall with back and legs straight and hands resting lightly on the wall for balance.',
    'Lift left foot off the ground so that all of your weight is on your right leg.',
    'Keep knee only slightly bent or else you will be placing too much emphasis on your quads.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=I7ujdec8b64&ab_channel=fleetfeetnashville',
  showTimer: false,
  advanceRap: 16,
  beginnerRap: 12,
  intermediateRap: 14,
  imageSrc: 'assets/all-workouts/wallRestingSinglCalfRise_L.gif',
);
Workout wallResistingSingleLegRight = Workout(
  title: 'Wall Resisting Single Leg Right',
  steps: [
    'Stand tall facing a wall with back and legs straight and hands resting lightly on the wall for balance.',
    'Lift left foot off the ground so that all of your weight is on your right leg.',
    'Keep knee only slightly bent or else you will be placing too much emphasis on your quads.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=I7ujdec8b64&ab_channel=fleetfeetnashville',
  showTimer: false,
  advanceRap: 16,
  beginnerRap: 12,
  intermediateRap: 14,
  imageSrc: 'assets/all-workouts/wallRestingSinglCalfRise_R.gif',
);
Workout lyingButterFlyStretch = Workout(
    title: 'Lying ButterFly Stretch',
    steps: [
      'Sit on the floor or a prop with the soles of your feet pressing into each other.',
      'To deepen the intensity, move your feet closer in toward your hips.',
      'Root down into your legs and sitting bones.',
      'Elongate and straighten your spine, tucking your chin in toward your chest.',
      'With each inhale, lengthen your spine and feel the line of energy extending out through the top of your head.',
      'With each exhale, fall heavy into the floor and relax or sink a bit more deeply into the stretch.'
    ],
    videoLink: 'https://www.youtube.com/watch?v=rdxD3POKbV8&ab_channel=Howcast',
    showTimer: true,
    duration: 30,
    imageSrc: 'assets/all-workouts/lyingButterFlyStretch.png');
Workout walkingLunges = Workout(
  title: 'Walking Lunges',
  steps: [
    'To begin, start by standing upright with your feet together.',
    'Placing both hands on your hips which will help to keep you balanced as you walk forward.',
    'Step forward with one leg while lowering your hips to the ground.',
    'With both knees bent, the front knee should be directly above the front foot and the back knee should be pointing downwards but not touching the ground.',
    'Push off with your front foot while bringing your back foot forward.',
    'Repeat the lunge with the other leg.',
  ],
  videoLink: 'https://www.youtube.com/watch?v=7mDWDlzFobQ&ab_channel=Howcast',
  showTimer: false,
  advanceRap: 14,
  intermediateRap: 12,
  imageSrc: 'assets/all-workouts/walking-lunge.gif',
);
Workout lateralSquat = Workout(
  title: 'Lateral Squat',
  steps: [
    'Stand up and place your feet double shoulder-width apart.',
    'Shift your weight to your right leg, bend your right knee, and push your hips back as if you’re going to sit down.',
    'Drop as low as possible while keeping your left leg straight.',
    'Keep your chest up and your weight on your right leg.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=RkiYM02RtJI&ab_channel=GarrettMcLaughlin',
  showTimer: false,
  advanceRap: 20,
  beginnerRap: 12,
  intermediateRap: 14,
  imageSrc: 'assets/all-workouts/lateralSquat.gif',
);
Workout calfStretchLeft = Workout(
  title: 'Calf Stretch Left',
  steps: [
    'Stand near a wall with one foot in front of the other, front knee slightly bent.',
    'Keep your back knee straight, your heel on the ground, and lean toward the wall.',
    'Feel the stretch all along the calf of your back leg.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=fEbF7Qb5vgM&ab_channel=JamesDunne',
  showTimer: true,
  duration: 30,
  imageSrc: 'assets/all-workouts/CalfStretchLeft.png',
);
Workout calfStretchRight = Workout(
  title: 'Calf Stretch Right',
  steps: [
    'Stand near a wall with one foot in front of the other, front knee slightly bent.',
    'Keep your back knee straight, your heel on the ground, and lean toward the wall.',
    'Feel the stretch all along the calf of your back leg.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=fEbF7Qb5vgM&ab_channel=JamesDunne',
  showTimer: true,
  duration: 30,
  imageSrc: 'assets/all-workouts/CalfStretchRight.png',
);
//----------------------------------SHOULDER--------------------------------------
Workout rhomboidPulls = Workout(
  title: 'Rhomboid Pulls',
  steps: [
    ' In this exercise, you have to stand width your feet shoulder with apart.',
    'Then raise your arms parallel to the ground, and bend your elbows.',
    'Pull your elbows back and squeeze your shoulder blades.'
  ],
  videoLink:
      'https://www.youtube.com/watch?v=KMgAmFD-Z6U&ab_channel=NAWRIHELATHYLIFE',
  showTimer: false,
  beginnerRap: 12,
  intermediateRap: 16,
  imageSrc: 'assets/all-workouts/rhomboidPulls.gif',
);
Workout sideArmRaise = Workout(
  title: 'Side Arm Raise',
  steps: [
    'Stand tall, position your feet roughly hip-distance apart.',
    'Check your posture—roll your shoulders back, engage your core, and look straight ahead.',
    'Raise your arms simultaneously just a couple inches out to each side and pause.',
    'Lift the hands up and out to each side, keeping your arms almost completely straight, stopping when your elbows reach shoulder-height and your body is forming a "T" shape. Breathe in as you lift.',
    'Pause and hold for a second at the top of the movement.',
    'Bringing your arms back to your sides. Breathe out as you lower the hands.'
  ],
  videoLink:
      'https://www.youtube.com/watch?v=eEcUyYlf8UI&ab_channel=LeapFitness',
  showTimer: false,
  intermediateRap: 16,
  beginnerRap: 12,
  imageSrc: 'assets/all-workouts/side arm raise.gif',
);
Workout reclinedRhomboidSqueezes = Workout(
  title: 'Reclined Rhomboid Squeezes',
  steps: [
    'In this exercise, you have to sit with your knees bent.',
    'Slightly lean your upper body back.',
    'Stretch your arm in front of you, then pull your elbow back to make your elbows at A 90-degree angle and squeeze your shoulder blades.'
  ],
  videoLink:
      'https://www.youtube.com/watch?v=olv2Sv9DwmA&ab_channel=LeapFitness',
  showTimer: false,
  beginnerRap: 12,
  imageSrc: 'assets/all-workouts/reclinedRomboidSqueeze.gif',
);
Workout armScissors = Workout(
  title: 'Arm Scissors',
  steps: [
    'you have to stand upright with your feet shoulder-width apart.',
    'Stretch your arm in front of you at shoulder height with one arm overlap the other in the shape of the letter X and then spread them apart.',
    'Switch arm, and repeat the exercise.'
  ],
  videoLink:
      'https://www.youtube.com/watch?v=dPDsW7xvuVY&ab_channel=LeapFitness',
  showTimer: true,
  duration: 30,
  imageSrc: 'assets/all-workouts/armScissor.gif',
);
Workout rhomboidPulls2 = Workout(
  title: 'Rhomboid Pulls',
  steps: [
    ' In this exercise, you have to stand width your feet shoulder with apart.',
    'Then raise your arms parallel to the ground, and bend your elbows.',
    'Pull your elbows back and squeeze your shoulder blades.'
  ],
  videoLink:
      'https://www.youtube.com/watch?v=KMgAmFD-Z6U&ab_channel=NAWRIHELATHYLIFE',
  showTimer: false,
  beginnerRap: 10,
  intermediateRap: 14,
  advanceRap: 18,
  imageSrc: 'assets/all-workouts/rhomboidPulls.gif',
);
Workout sideArmRaise2 = Workout(
  title: 'Side Arm Raise',
  steps: [
    'Stand tall, position your feet roughly hip-distance apart.',
    'Check your posture—roll your shoulders back, engage your core, and look straight ahead.',
    'Raise your arms simultaneously just a couple inches out to each side and pause.',
    'Lift the hands up and out to each side, keeping your arms almost completely straight, stopping when your elbows reach shoulder-height and your body is forming a "T" shape. Breathe in as you lift.',
    'Pause and hold for a second at the top of the movement.',
    'Bringing your arms back to your sides. Breathe out as you lower the hands.'
  ],
  videoLink:
      'https://www.youtube.com/watch?v=eEcUyYlf8UI&ab_channel=LeapFitness',
  showTimer: false,
  beginnerRap: 10,
  imageSrc: 'assets/all-workouts/side arm raise.gif',
);
Workout reclinedRhomboidSqueezes2 = Workout(
  title: 'Reclined Rhomboid Squeezes',
  steps: [
    'In this exercise, you have to sit with your knees bent.',
    'Slightly lean your upper body back.',
    'Stretch your arm in front of you, then pull your elbow back to make your elbows at A 90-degree angle and squeeze your shoulder blades.'
  ],
  videoLink:
      'https://www.youtube.com/watch?v=olv2Sv9DwmA&ab_channel=LeapFitness',
  showTimer: false,
  beginnerRap: 10,
  imageSrc: 'assets/all-workouts/reclinedRomboidSqueeze.gif',
);
Workout floorTricepsDips = Workout(
  title: 'Floor Triceps Dips',
  steps: [
    'Sit on the floor and grip the edge next to your hips. Your fingers should be pointed at your feet.',
    'Your legs are extended and your feet should be about hip-width apart with the heels touching the ground.',
    'Press into your palms to lift your body and slide forward.',
    'Lower yourself until your elbows are bent between 45 and 90 degrees.',
    'Slowly push yourself back up to the start position and repeat. Control the movement throughout the range of motion.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=s3Mppxwx1o8&ab_channel=MoveItMonday',
  showTimer: false,
  intermediateRap: 12,
  advanceRap: 16,
  imageSrc: 'assets/all-workouts/floorTricepsDipes.gif',
);
Workout pikePushUps = Workout(
  title: 'Pike Push Ups',
  imageSrc: 'assets/all-workouts/pikePushUps_.gif',
  steps: [
    'Get down on all fours, placing your hands slightly wider than your shoulders.',
    'Straighten your arms and legs.',
    'Lower your body until your chest nearly touches the floor.',
    'Pause, then push yourself back up.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=sposDXWEB0A&ab_channel=GlobalBodyweightTraining',
  advanceRap: 16,
  showTimer: false,
);
Workout reversePushUps = Workout(
  title: 'Reverse Push Ups',
  steps: [
    'Start with your body straight and your arms bent, holding yourself an inch or two off the floor, like the halfway point of a regular pushup.',
    'Push your buttocks upward and backward toward your feet, making sure your knees don’t touch the floor.',
    'Keep your hands flat on the floor, so that at the end of the move, your arms are extended straight in front of you.',
    'Return to the starting position.'
  ],
  videoLink:
      'https://www.youtube.com/watch?v=a00N2M7I1_o&ab_channel=Men%27sHealth',
  showTimer: false,
  advanceRap: 14,
  imageSrc: 'assets/all-workouts/reversePushups.gif',
);
Workout threadTheNeedleL = Workout(
  title: 'Thread The Needle Left',
  steps: [
    'Begin on your hands and knees. Place your wrists directly under your shoulders and your knees directly under your hips.',
    'Point your fingertips to the top of your mat. Place your shins and knees hip-width apart. Center your head in a neutral position and soften your gaze downward.',
    'On an exhalation, slide your right arm underneath your left arm with your palm facing up. Let your right shoulder come all the way down to the mat.',
    'Keep your left elbow lifting and your hips raised.',
    'Let your upper back broaden. Soften and relax your lower back. Allow all of the tension in your shoulders, arms, and neck to drain away.'
  ],
  videoLink:
      'https://www.youtube.com/watch?v=M8-bBGOilms&feature=emb_logo&ab_channel=AssociatedBodywork%26MassageProfessionals%28ABMP%29',
  showTimer: true,
  duration: 30,
  imageSrc: 'assets/all-workouts/threadTheNeedleLeft.png',
);
Workout threadTheNeedleR = Workout(
  title: 'Thread The Needle Right',
  steps: [
    'Begin on your hands and knees. Place your wrists directly under your shoulders and your knees directly under your hips.',
    'Point your fingertips to the top of your mat. Place your shins and knees hip-width apart. Center your head in a neutral position and soften your gaze downward.',
    'On an exhalation, slide your right arm underneath your left arm with your palm facing up. Let your right shoulder come all the way down to the mat.',
    'Keep your left elbow lifting and your hips raised.',
    'Let your upper back broaden. Soften and relax your lower back. Allow all of the tension in your shoulders, arms, and neck to drain away.'
  ],
  videoLink:
      'https://www.youtube.com/watch?v=M8-bBGOilms&feature=emb_logo&ab_channel=AssociatedBodywork%26MassageProfessionals%28ABMP%29',
  showTimer: true,
  duration: 30,
  imageSrc: 'assets/all-workouts/threadTheNeedleRight.png',
);
Workout floorTricepsDips2 = Workout(
  title: 'Floor Triceps Dips',
  steps: [
    'Sit on the floor and grip the edge next to your hips. Your fingers should be pointed at your feet.',
    'Your legs are extended and your feet should be about hip-width apart with the heels touching the ground.',
    'Press into your palms to lift your body and slide forward.',
    'Lower yourself until your elbows are bent between 45 and 90 degrees.',
    'Slowly push yourself back up to the start position and repeat. Control the movement throughout the range of motion.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=s3Mppxwx1o8&ab_channel=MoveItMonday',
  showTimer: false,
  intermediateRap: 10,
  advanceRap: 12,
  imageSrc: 'assets/all-workouts/floorTricepsDipes.gif',
);
Workout pikePushUps2 = Workout(
  title: 'Pike Push Ups',
  imageSrc: 'assets/all-workouts/pikePushUps_.gif',
  steps: [
    'Get down on all fours, placing your hands slightly wider than your shoulders.',
    'Straighten your arms and legs.',
    'Lower your body until your chest nearly touches the floor.',
    'Pause, then push yourself back up.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=sposDXWEB0A&ab_channel=GlobalBodyweightTraining',
  advanceRap: 12,
  showTimer: false,
);
Workout reversePushUps2 = Workout(
  title: 'Reverse Push Ups',
  steps: [
    'Start with your body straight and your arms bent, holding yourself an inch or two off the floor, like the halfway point of a regular pushup.',
    'Push your buttocks upward and backward toward your feet, making sure your knees don’t touch the floor.',
    'Keep your hands flat on the floor, so that at the end of the move, your arms are extended straight in front of you.',
    'Return to the starting position.'
  ],
  videoLink:
      'https://www.youtube.com/watch?v=a00N2M7I1_o&ab_channel=Men%27sHealth',
  showTimer: false,
  advanceRap: 12,
  imageSrc: 'assets/all-workouts/reversePushups.gif.gif',
);
Workout catCowPose = Workout(
  title: 'Cat Cow Pose',
  steps: [
    'On all fours, your knees should be hip width distance and your hands should be directly below your shoulders. Your spine is neutral here.',
    'Inhale as you drop your belly and lift your gaze and your tail bone towards the sky. (Cow Pose)',
    'Exhale as you slowly tuck your chin towards your chest, lift your mid-back towards the sky and scoop your tailbone under. Like you\'re imitating a scary Halloween cat. (Cat Pose)',
    'Do at least 30 second these then return to a neutral spine.',
  ],
  videoLink: 'https://www.youtube.com/watch?v=kqnua4rHVVA&ab_channel=Howcast',
  showTimer: true,
  duration: 30,
  imageSrc: 'assets/all-workouts/catCowPose.gif',
);
Workout plankUp = Workout(
    title: 'Plank Up',
    steps: [
      'Get down on the ground on the ground in plank position (only forearms and toes touching the ground).',
      'Make your body into a straight line.',
      'Lift your left forearm off the ground and place your left hand down.',
      'Do the same with your right arm.',
      'Push up so that you are now in push-up position with your arms locked out.',
      'Now place your left forearm back on the ground followed by your right.',
    ],
    videoLink:
        'https://www.youtube.com/watch?v=Sb6z8krZPeI&feature=emb_logo&ab_channel=YSTExercises',
    showTimer: false,
    advanceRap: 16,
    intermediateRap: 12,
    imageSrc: 'assets/all-workouts/plankUp.gif');
Workout inchWorm = Workout(
  title: 'Inch Worm',
  steps: [
    'Stand tall and roll down until your hands reach the floor.',
    'Walk your hands forward until you’re one long line in a plank position.',
    'Take tiny steps walking your feet forward until they reach your hands.',
    'Walk hands out to plank again, and feet back to hands.  Continue repeating this several times.',
  ],
  videoLink: 'https://www.youtube.com/watch?v=VSp0z7Mp5IU&ab_channel=Howcast',
  showTimer: false,
  advanceRap: 16,
  intermediateRap: 12,
  beginnerRap: 10,
  imageSrc: 'assets/all-workouts/Inchworm.gif',
);
Workout plankUp2 = Workout(
  title: 'Plank Up',
  steps: [
    'Get down on the ground on the ground in plank position (only forearms and toes touching the ground).',
    'Make your body into a straight line.',
    'Lift your left forearm off the ground and place your left hand down.',
    'Do the same with your right arm.',
    'Push up so that you are now in push-up position with your arms locked out.',
    'Now place your left forearm back on the ground followed by your right.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=Sb6z8krZPeI&feature=emb_logo&ab_channel=YSTExercises',
  showTimer: false,
  advanceRap: 12,
  intermediateRap: 10,
  imageSrc: 'assets/all-workouts/plankUp.gif',
);
Workout reverseSnowAngle = Workout(
  title: 'Reverse Snow Angle',
  steps: [
    'Place your forehead on the thick part of a mat or folded towel.',
    'Lie face down with your hands relaxed at your side.',
    'Keeping your shoulders seated tightly in their socket and your arms locked out.',
    'Raise your hands overhead.Your hands and arms should remain a few inches off of the ground.',
    'Move your hands to your sides.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=UBVJg7RbuHU&ab_channel=LeapFitness',
  showTimer: false,
  advanceRap: 16,
  imageSrc: 'assets/all-workouts/reverseSnowAngel.gif',
);
Workout childPose = Workout(
  title: 'Child\'s Pose',
  steps: [
    'Sit on your heels on a yoga mat or on the floor.',
    'Either keep your knees together or apart.',
    'Slowly, bend forward by lowering your forehead to touch the floor, exhaling as you do so.',
    'Keep your arms alongside your body. Make sure that your palms are facing up.',
    'Alternatively, you can reach out your arms towards the front of the yoga mat, palms placed facing down on the mat.',
    'Now that you are in this pose, gently press your chest on the thighs (or between the thighs if the latter are apart).'
  ],
  videoLink:
      'https://www.youtube.com/watch?v=qYvYsFrTI0U&ab_channel=ViveHealth',
  showTimer: true,
  duration: 30,
  imageSrc: 'assets/all-workouts/child\'sPose.png',
);
Workout inchWorm2 = Workout(
  title: 'Inch Worm',
  steps: [
    'Stand tall and roll down until your hands reach the floor.',
    'Walk your hands forward until you’re one long line in a plank position.',
    'Take tiny steps walking your feet forward until they reach your hands.',
    'Walk hands out to plank again, and feet back to hands.  Continue repeating this several times.',
  ],
  videoLink: 'https://www.youtube.com/watch?v=VSp0z7Mp5IU&ab_channel=Howcast',
  showTimer: false,
  beginnerRap: 10,
  intermediateRap: 12,
  advanceRap: 14,
  imageSrc: 'assets/all-workouts/Inchworm.gif',
);
// ABS
Workout abdominalCrunches = Workout(
    title: 'Abdominal Crunches',
    videoLink:
        'https://www.youtube.com/watch?v=_YVhhXc2pSY&ab_channel=WahooFitness',
    steps: [
      'Lie down on your back. Plant your feet on the floor, hip-width apart.',
      'Bend your knees and place your arms across your chest.',
      'Contract your abs and inhale.',
      'Exhale and lift your upper body, keeping your head and neck relaxed.',
      'Inhale and return to the starting position.'
    ],
    showTimer: false,
    beginnerRap: 20,
    intermediateRap: 20,
    advanceRap: 20,
    imageSrc: 'assets/all-workouts/abdominalCrunches.gif');
Workout russianTwist = Workout(
  title: 'Russian Twist',
  videoLink:
      'https://www.youtube.com/watch?v=BlJQtdcCzeA&ab_channel=StephanieSequeira',
  steps: [
    'Lie down on your back, facing up.',
    'Place both your hands underneath your buttocks.',
    'Keep your lower back on the ground as you lift the right leg off the ground slightly past hip height, and lift the left leg so it hovers a few inches off the floor.',
    'Hold for 2 seconds, then switch the position of the legs, making a flutter kick motion.',
    'For more of a challenge, lift your head and neck off the floor.'
  ],
  showTimer: false,
  beginnerRap: 30,
  intermediateRap: 36,
  advanceRap: 40,
  imageSrc: 'assets/all-workouts/russianTwist.gif',
);
Workout flutterKikes = Workout(
  title: 'Flutter Kikes',
  videoLink:
      'https://www.youtube.com/watch?v=BlJQtdcCzeA&ab_channel=StephanieSequeira',
  steps: [
    'Lie down on your back, facing up.',
    'Place both your hands underneath your buttocks.',
    'Keep your lower back on the ground as you lift the right leg off the ground slightly past hip height, and lift the left leg so it hovers a few inches off the floor.',
    'Hold for 2 seconds, then switch the position of the legs, making a flutter kick motion.',
    'For more of a challenge, lift your head and neck off the floor.'
  ],
  showTimer: false,
  beginnerRap: 12,
  intermediateRap: 16,
  advanceRap: 20,
  imageSrc: 'assets/all-workouts/flutterKikes.gif',
);
Workout pulseUp = Workout(
  title: 'Pulse Up',
  videoLink: 'https://www.youtube.com/watch?v=wzhQMdkMzyA&ab_channel=Sears',
  steps: [
    'Lie down on your back and raise your legs so they are pointing straight up toward the ceiling.',
    'Place your hands under your tailbone or along your sides with palms down. This is the starting position.',
    'Begin exercise by raising your hips straight up off the ground, while keeping your legs perpendicular to the ground. Try not to let your legs fall backward or forward, but straight up.',
    'Pause, then slowly lower hips back down to starting position. Repeat as necessary.'
  ],
  showTimer: false,
  beginnerRap: 16,
  intermediateRap: 20,
  imageSrc: 'assets/all-workouts/pulseUp.gif',
);
Workout mountainClimbing = Workout(
  title: 'Mountain Climbing',
  videoLink: 'https://www.youtube.com/watch?v=UOGvtqv856A&ab_channel=Howcast',
  steps: [
    'Start in a traditional plank with your shoulders directly over your hands.',
    'think about pulling your belly button toward your spine and lift up your right knee, bringing it toward your elbow.',
    'Return the right knee back to the starting position as you simultaneously drive your left knee up toward your left elbow.',
    'Continue switching legs and begin to pick up the pace until it feels like you\'re "running" in place in a plank position.'
  ],
  showTimer: false,
  beginnerRap: 16,
  intermediateRap: 20,
  imageSrc: 'assets/all-workouts/mountainClimbing.gif',
);
Workout russianTwist2 = Workout(
  title: 'Russian Twist',
  videoLink:
      'https://www.youtube.com/watch?v=BlJQtdcCzeA&ab_channel=StephanieSequeira',
  steps: [
    'Lie down on your back, facing up.',
    'Place both your hands underneath your buttocks.',
    'Keep your lower back on the ground as you lift the right leg off the ground slightly past hip height, and lift the left leg so it hovers a few inches off the floor.',
    'Hold for 2 seconds, then switch the position of the legs, making a flutter kick motion.',
    'For more of a challenge, lift your head and neck off the floor.'
  ],
  showTimer: false,
  beginnerRap: 20,
  intermediateRap: 24,
  advanceRap: 30,
  imageSrc: 'assets/all-workouts/russianTwist.gif',
);
Workout elbowPlanks = Workout(
  title: 'Elbow Planks',
  videoLink: 'https://www.youtube.com/watch?v=zuHZyVg3zRA&ab_channel=PFITtv',
  steps: [
    'Assume a push-up position but bend your arms at your elbows so your weight rests on your forearms.',
    'Tighten your abs, clench your glutes and keep your body straight from head to heels.',
    'Hold as long as you can.'
  ],
  showTimer: true,
  duration: 20,
  imageSrc: 'assets/all-workouts/elbowPlank.png',
);
Workout advanceElbowPlanks = Workout(
  title: 'Elbow Planks',
  videoLink: 'https://www.youtube.com/watch?v=zuHZyVg3zRA&ab_channel=PFITtv',
  steps: [
    'Assume a push-up position but bend your arms at your elbows so your weight rests on your forearms.',
    'Tighten your abs, clench your glutes and keep your body straight from head to heels.',
    'Hold as long as you can.'
  ],
  showTimer: true,
  duration: 60,
  imageSrc: 'assets/all-workouts/elbowPlank.png',
);
Workout abdominalCrunches2 = Workout(
  title: 'Abdominal Crunches',
  videoLink:
      'https://www.youtube.com/watch?v=_YVhhXc2pSY&ab_channel=WahooFitness',
  steps: [
    'Lie down on your back. Plant your feet on the floor, hip-width apart.',
    'Bend your knees and place your arms across your chest.',
    'Contract your abs and inhale.',
    'Exhale and lift your upper body, keeping your head and neck relaxed.',
    'Inhale and return to the starting position.'
  ],
  showTimer: false,
  beginnerRap: 12,
  advanceRap: 20,
  imageSrc: 'assets/all-workouts/abdominalCrunches.gif',
);
Workout flutterKikes2 = Workout(
  title: 'Flutter Kikes',
  videoLink:
      'https://www.youtube.com/watch?v=BlJQtdcCzeA&ab_channel=StephanieSequeira',
  steps: [
    'Lie down on your back, facing up.',
    'Place both your hands underneath your buttocks.',
    'Keep your lower back on the ground as you lift the right leg off the ground slightly past hip height, and lift the left leg so it hovers a few inches off the floor.',
    'Hold for 2 seconds, then switch the position of the legs, making a flutter kick motion.',
    'For more of a challenge, lift your head and neck off the floor.'
  ],
  showTimer: false,
  beginnerRap: 12,
  intermediateRap: 16,
  advanceRap: 20,
  imageSrc: 'assets/all-workouts/flutterKikes.gif',
);
Workout mountainClimbing2 = Workout(
    title: 'Mountain Climbing',
    videoLink: 'https://www.youtube.com/watch?v=UOGvtqv856A&ab_channel=Howcast',
    steps: [
      'Start in a traditional plank with your shoulders directly over your hands.',
      'think about pulling your belly button toward your spine and lift up your right knee, bringing it toward your elbow.',
      'Return the right knee back to the starting position as you simultaneously drive your left knee up toward your left elbow.',
      'Continue switching legs and begin to pick up the pace until it feels like you\'re "running" in place in a plank position.'
    ],
    showTimer: false,
    beginnerRap: 16,
    imageSrc: 'assets/all-workouts/mountainClimbing.gif');
Workout pulseUp2 = Workout(
    title: 'Pulse Up',
    videoLink: 'https://www.youtube.com/watch?v=wzhQMdkMzyA&ab_channel=Sears',
    steps: [
      'Lie down on your back and raise your legs so they are pointing straight up toward the ceiling.',
      'Place your hands under your tailbone or along your sides with palms down. This is the starting position.',
      'Begin exercise by raising your hips straight up off the ground, while keeping your legs perpendicular to the ground. Try not to let your legs fall backward or forward, but straight up.',
      'Pause, then slowly lower hips back down to starting position. Repeat as necessary.'
    ],
    showTimer: false,
    beginnerRap: 12,
    intermediateRap: 16,
    imageSrc: 'assets/all-workouts/pulseUp.gif');
Workout wipers = Workout(
    title: 'Wipers',
    steps: [
      'Lie on your back with your arms straight out to the sides.',
      'Rotate the hips to one side, without letting the legs touch the floor.',
      'Lift your legs and return to the starting position.',
      'Rotate the hips to the opposite side and repeat until set is complete.'
    ],
    videoLink: 'https://www.youtube.com/watch?v=X59_4RrU_aA&ab_channel=Howcast',
    showTimer: true,
    duration: 30,
    imageSrc: 'assets/all-workouts/wipers.gif');
Workout reverseCrunches = Workout(
  title: 'Reverse Crunches',
  showTimer: false,
  steps: [
    'Lie on your back with your knees together and your legs bent to 90 degrees,feet planted on the floor.',
    'Place your palms face down on the floor for support.',
    'Tighten your abs to lift your hips off the floor as you crunch your knees inward to your chest.',
    'Pause at the top for a moment, then lower back down without allowing your lower back to arch and lose contact with the floor.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=gAyTBB4lm3I&ab_channel=LivestrongWoman',
  intermediateRap: 20,
  advanceRap: 30,
  imageSrc: 'assets/all-workouts/reverseCrunches.gif',
);
Workout vUps = Workout(
  title: 'V-Ups',
  steps: [
    'Lie down on a flat surface or mat.',
    'Start with your legs straight, then come up.',
    'Touch your toes, and then let your torso fall back down.',
    'Bring your legs up into the air, touching your toes again.'
  ],
  videoLink:
      'https://www.youtube.com/watch?v=t6OC23JDQLU&ab_channel=PaleoHacks',
  showTimer: false,
  intermediateRap: 20,
  advanceRap: 24,
  imageSrc: 'assets/all-workouts/VUps.gif',
);
Workout sidePlankRight = Workout(
    title: 'Side Plank Right',
    steps: [
      'Lie on your right side, legs extended and stacked from hip to feet.',
      'Engage your abdominal muscles, drawing your navel toward your spine.',
      'Lift your hips and knees from the mat while exhaling.',
      'After several breaths, inhale and return to the starting position.',
    ],
    videoLink: 'https://www.youtube.com/watch?v=K2VljzCC16g&ab_channel=Howcast',
    showTimer: true,
    duration: 30,
    imageSrc: 'assets/all-workouts/sidePlankRight.png');
Workout sidePlankLeft = Workout(
    title: 'Side Plank Left',
    steps: [
      'Lie on your left side, legs extended and stacked from hip to feet.',
      'Engage your abdominal muscles, drawing your navel toward your spine.',
      'Lift your hips and knees from the mat while exhaling.',
      'After several breaths, inhale and return to the starting position.',
    ],
    videoLink: 'https://www.youtube.com/watch?v=K2VljzCC16g&ab_channel=Howcast',
    showTimer: true,
    duration: 30,
    imageSrc: 'assets/all-workouts/sidePlankLeft.png');
Workout vUps2 = Workout(
    title: 'V-Ups',
    steps: [
      'Lie down on a flat surface or mat.',
      'Start with your legs straight, then come up.',
      'Touch your toes, and then let your torso fall back down.',
      'Bring your legs up into the air, touching your toes again.'
    ],
    videoLink:
        'https://www.youtube.com/watch?v=t6OC23JDQLU&ab_channel=PaleoHacks',
    showTimer: false,
    intermediateRap: 16,
    advanceRap: 20,
    imageSrc: 'assets/all-workouts/VUps.gif');
Workout reverseCrunches2 = Workout(
  title: 'Reverse Crunches',
  showTimer: true,
  steps: [
    'Lie on your back with your knees together and your legs bent to 90 degrees,feet planted on the floor.',
    'Place your palms face down on the floor for support.',
    'Tighten your abs to lift your hips off the floor as you crunch your knees inward to your chest.',
    'Pause at the top for a moment, then lower back down without allowing your lower back to arch and lose contact with the floor.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=gAyTBB4lm3I&ab_channel=LivestrongWoman',
  intermediateRap: 16,
  advanceRap: 24,
  imageSrc: 'assets/all-workouts/reverseCrunches.gif',
); //
Workout sidePlankRight2 = Workout(
  title: 'Side Plank Right',
  steps: [
    'Lie on your right side, legs extended and stacked from hip to feet.',
    'Engage your abdominal muscles, drawing your navel toward your spine.',
    'Lift your hips and knees from the mat while exhaling.',
    'After several breaths, inhale and return to the starting position.',
  ],
  videoLink: 'https://www.youtube.com/watch?v=K2VljzCC16g&ab_channel=Howcast',
  showTimer: true,
  duration: 20,
  imageSrc: 'assets/all-workouts/sidePlankRight.png',
);
Workout sidePlankLeft2 = Workout(
    title: 'Side Plank Left',
    steps: [
      'Lie on your left side, legs extended and stacked from hip to feet.',
      'Engage your abdominal muscles, drawing your navel toward your spine.',
      'Lift your hips and knees from the mat while exhaling.',
      'After several breaths, inhale and return to the starting position.',
    ],
    videoLink: 'https://www.youtube.com/watch?v=K2VljzCC16g&ab_channel=Howcast',
    showTimer: true,
    duration: 20,
    imageSrc: 'assets/all-workouts/sidePlankLeft.png');
Workout pushUpsRotation = Workout(
  title: 'Push-Ups & Rotation',
  steps: [
    'Start out on the mat in a push-up positions, hands and feet on the floor with your body off the mat.',
    'Perform a push-up by lowering your body to the mat and extending your self back up off the mat.',
    'Now rotate your body to the right by lifting your right arm off the mat and pointing it at the ceiling. This should cause you to be in the position of a side plank.',
    'Return your right hand to the mat, back into push-up position and then perform a push-up however repeat the twist with your left hand.'
  ],
  videoLink: 'https://youtu.be/YU0gWh72a3k',
  showTimer: false,
  advanceRap: 24,
  intermediateRap: 16,
  imageSrc: 'assets/all-workouts/pushUpsRotation.gif',
);
Workout pushUpsRotation2 = Workout(
  title: 'Push-Ups & Rotation',
  steps: [
    'Start out on the mat in a push-up positions, hands and feet on the floor with your body off the mat.',
    'Perform a push-up by lowering your body to the mat and extending your self back up off the mat.',
    'Now rotate your body to the right by lifting your right arm off the mat and pointing it at the ceiling. This should cause you to be in the position of a side plank.',
    'Return your right hand to the mat, back into push-up position and then perform a push-up however repeat the twist with your left hand.'
  ],
  videoLink: 'https://youtu.be/YU0gWh72a3k',
  showTimer: false,
  advanceRap: 20,
  intermediateRap: 12,
  imageSrc: 'assets/all-workouts/pushUpsRotation.gif',
);
Workout spineLumberL = Workout(
    title: 'Spine Lumber Left',
    steps: [
      'Begin lying comfortably on the back. Bend your knees in to your chest and extend your arms out alongside the body in a “T” formation, with your palms facing up toward the ceiling.',
      'Inhale here, lengthening your tailbone down toward the ground. As you exhale, drop both of your bent knees over to the right, and send your gaze over to the left.',
      'Keep your knees and feet close together, and press the backs of your shoulderblades down toward the mat.',
      'Remain in the twist for 5-10 breaths, then inhale to come back up to centre. On your next exhale, drop your knees to the left, and send your gaze to the right.',
      'Inhale to come back up to centre. Wrap your arms around your legs and gently rock from side to side to release the low back, then extend both legs straight down onto the mat.',
    ],
    videoLink:
        'https://www.youtube.com/watch?v=BzYBkAvdCJY&ab_channel=RehabMyPatient',
    showTimer: true,
    duration: 30,
    imageSrc: 'assets/all-workouts/spineLumberL.png');
Workout spineLumberR = Workout(
  title: 'Spine Lumber Right)',
  steps: [
    'Begin lying comfortably on the back. Bend your knees in to your chest and extend your arms out alongside the body in a “T” formation, with your palms facing up toward the ceiling.',
    'Inhale here, lengthening your tailbone down toward the ground. As you exhale, drop both of your bent knees over to the right, and send your gaze over to the left.',
    'Keep your knees and feet close together, and press the backs of your shoulderblades down toward the mat.',
    'Remain in the twist for 5-10 breaths, then inhale to come back up to centre. On your next exhale, drop your knees to the left, and send your gaze to the right.',
    'Inhale to come back up to centre. Wrap your arms around your legs and gently rock from side to side to release the low back, then extend both legs straight down onto the mat.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=BzYBkAvdCJY&ab_channel=RehabMyPatient',
  showTimer: true,
  duration: 30,
  imageSrc: 'assets/all-workouts/spineLumberR.png',
);
// Chest
Workout jumpingJacks = Workout(
  videoLink:
      'https://www.youtube.com/watch?v=iSSAk4XCsRA&ab_channel=RedefiningStrength',
  title: 'Jumping Jacks',
  steps: [
    'Stand upright with your legs together, arms at your sides.',
    'Bend your knees slightly, and jump into the air.',
    'As you jump, spread your legs to be about shoulder-width apart.',
    'Stretch your arms out and over your head.',
    'Jump back to starting position.'
  ],
  showTimer: true,
  duration: 30,

  imageSrc: 'assets/all-workouts/jumpingJacks.gif',
);

Workout beginnerJumpingJacks = Workout(
  videoLink:
  'https://www.youtube.com/watch?v=iSSAk4XCsRA&ab_channel=RedefiningStrength',
  title: 'Jumping Jacks',
  steps: [
    'Stand upright with your legs together, arms at your sides.',
    'Bend your knees slightly, and jump into the air.',
    'As you jump, spread your legs to be about shoulder-width apart.',
    'Stretch your arms out and over your head.',
    'Jump back to starting position.'
  ],
  showTimer: true,
  duration: 20,

  imageSrc: 'assets/all-workouts/jumpingJacks.gif',
);
Workout kneePushUps = Workout(
    title: 'Knee Push-ups',
    steps: [
      '  Place the knees on the floor, the hands below the shoulders and cross your feet.',
      'Keeping your back straight, start bending the elbows until your chest is almost touching the floor.',
      'Pause and push back to the starting position.',
      'Repeat until the set is complete.',
    ],
    videoLink:
        'https://www.youtube.com/watch?v=utzhPQuXWcA&ab_channel=GetExerciseConfident',
    showTimer: false,
    beginnerRap: 12,
    intermediateRap: 12,
    imageSrc: 'assets/all-workouts/kneePushUps.gif');
Workout inclinePushUps = Workout(
  title: 'Incline Push-ups',
  steps: [
    'Assume a standard push-up position. But rather than placing your hands on the ground find a raised platform, bench or even a step to place your hands.',
    'Place hands slightly farther than shoulder-width apart and feet on the ground and on the balls of your feet. Body should be straight from your heels to your head.',
    'Keep elbows tucked in a lower yourself down until your chest briefly touches the raise surface, pause, then immediately push up as quickly as possible.'
  ],
  videoLink:
      'https://www.youtube.com/watch?v=Me9bHFAxnCs&ab_channel=TigerFitness',
  showTimer: false,
  beginnerRap: 10,
  intermediateRap: 14,
  imageSrc: 'assets/all-workouts/inclinePushUps.gif',
);
Workout inclinePushUps2 = Workout(
  title: 'Incline Push-ups',
  steps: [
    'Assume a standard push-up position. But rather than placing your hands on the ground find a raised platform, bench or even a step to place your hands.',
    'Place hands slightly farther than shoulder-width apart and feet on the ground and on the balls of your feet. Body should be straight from your heels to your head.',
    'Keep elbows tucked in a lower yourself down until your chest briefly touches the raise surface, pause, then immediately push up as quickly as possible.'
  ],
  videoLink:
      'https://www.youtube.com/watch?v=Me9bHFAxnCs&ab_channel=TigerFitness',
  showTimer: false,
  intermediateRap: 10,
  imageSrc: 'assets/all-workouts/inclinePushUps.gif',
);
Workout tricepsDips = Workout(
  title: 'Triceps Dips',
  steps: [
    'Grip the front edges of a chair or bench with your hand.',
    'Hover your butt just off and in front of the seat, feet flat, and legs bent so thighs are parallel to the floor.',
    'Straighten your arms. This is your start position.'
        'Lower your body toward the floor until your arms form 90-degree angles.',
    'Then, engage your triceps to press back to start.',
  ],
  videoLink: 'https://www.youtube.com/watch?v=6kALZikXxLc&ab_channel=Howcast',
  showTimer: false,
  beginnerRap: 12,
  intermediateRap: 16,
  advanceRap: 24,
  imageSrc: 'assets/all-workouts/tricepsdips.gif',
);
Workout pushUps = Workout(
  title: 'Push-Ups',
  steps: [
    'Get down on all fours, placing your hands slightly wider than your shoulders.',
    'Straighten your arms and legs.',
    'Lower your body until your chest nearly touches the floor.',
    'Pause, then push yourself back up.'
  ],
  videoLink: 'https://www.youtube.com/watch?v=rjc0O7OXS3g&ab_channel=DoctorOz',
  showTimer: false,
  beginnerRap: 10,
  intermediateRap: 12,
  advanceRap: 16,
  imageSrc: 'assets/all-workouts/pushUp.gif',
);
Workout kneePushUps2 = Workout(
  title: 'Knee Push-ups',
  steps: [
    '  Place the knees on the floor, the hands below the shoulders and cross your feet.',
    'Keeping your back straight, start bending the elbows until your chest is almost touching the floor.',
    'Pause and push back to the starting position.',
    'Repeat until the set is complete.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=utzhPQuXWcA&ab_channel=GetExerciseConfident',
  showTimer: false,
  beginnerRap: 8,
  imageSrc: 'assets/all-workouts/kneePushUps.gif',
);
Workout tricepsDips2 = Workout(
  title: 'Triceps Dips',
  steps: [
    'Grip the front edges of a chair or bench with your hand.',
    'Hover your butt just off and in front of the seat, feet flat, and legs bent so thighs are parallel to the floor.',
    'Straighten your arms. This is your start position.'
        'Lower your body toward the floor until your arms form 90-degree angles.',
    'Then, engage your triceps to press back to start.',
  ],
  videoLink: 'https://www.youtube.com/watch?v=6kALZikXxLc&ab_channel=Howcast',
  showTimer: false,
  beginnerRap: 10,
  advanceRap: 22,
  imageSrc: 'assets/all-workouts/tricepsdips.gif',
);
Workout pushUps2 = Workout(
  title: 'Push-Ups',
  steps: [
    'Get down on all fours, placing your hands slightly wider than your shoulders.',
    'Straighten your arms and legs.',
    'Lower your body until your chest nearly touches the floor.',
    'Pause, then push yourself back up.'
  ],
  videoLink: 'https://www.youtube.com/watch?v=rjc0O7OXS3g&ab_channel=DoctorOz',
  showTimer: false,
  beginnerRap: 8,
  intermediateRap: 10,
  advanceRap: 12,
  imageSrc: 'assets/all-workouts/pushUp.gif',
);
Workout cobraStretch = Workout(
  title: 'Cobra Stretch',
  videoLink:
      'https://www.youtube.com/watch?v=JDcdhTuycOI&ab_channel=FitnessBlender',
  steps: [
    'Lie on your belly.',
    'Place your palms on the floor just behind your shoulders.',
    'Firm and lengthen your legs and tailbone back.',
    'Gently lift your navel and begin to pull your hands against the mat.',
    'Lift your chest forward and up, straightening your arms as much as you can without straining your back.'
  ],
  showTimer: true,
  duration: 30,
  imageSrc: 'assets/all-workouts/cobraStratch.png',
);
Workout chestStretch = Workout(
  title: 'Chest Stretch',
  steps: [
    'Stand in an open doorway. Raise each arm up to the side, bent at 90-degree angles with palms forward. Rest your palms on the door frame.',
    'Slowly step forward with one foot. Feel the stretch in your shoulders and chest. Stand upright and don’t lean forward.',
    'Hold for 30 seconds. Step back and relax.',
  ],
  videoLink:
      'https://www.youtube.com/watch?v=CEQMx4zFwYs&ab_channel=MidwestOrtho',
  showTimer: true,
  duration: 30,
  imageSrc: 'assets/all-workouts/ChestStretches.png',
);
Workout hinduPushUps = Workout(
  title: 'Hindu Push-ups',
  steps: [
    'Assume a push-up position with your feet hip-width apart. Keep your core tight and back flat.',
    'Push your torso backward and raise your butt up to move into a pike position so your body forms an inverted V.',
    'Bend your elbows to lower your upper chest to the ground while keeping your butt up. As you lower your chest, drop your butt down so your body is in a straight line when you\'re closest to the ground.',
    'Straighten your arms to push your chest up, but allow for a slight arch in your back similar to the yoga Upward Dog position.'
  ],
  videoLink: 'https://www.youtube.com/watch?v=nBLy1IGtSJ8&ab_channel=AnyUp',
  showTimer: false,
  intermediateRap: 12,
  advanceRap: 16,
  imageSrc: 'assets/all-workouts/hinduPushUps.gif',
);
Workout wideArmPushUps = Workout(
    title: 'Wide Arm Push-ups',
    steps: [
      'Keep your shoulders, spine, and hips in a straight line.',
      'Lengthen your spine to keep your back straight.',
      'Make sure your hips don\'t sag down or point upward.',
      'Look at a spot on the floor ahead of you as you keep your neck neutral.',
      'Engage your core and gluteal muscles when you do the exercise.'
    ],
    videoLink:
        'https://www.youtube.com/watch?v=kBREQ4OSds8&ab_channel=LeapFitness',
    showTimer: false,
    intermediateRap: 16,
    advanceRap: 16,
    imageSrc: 'assets/all-workouts/wideArmPushUps.gif');
Workout staggeredPushUps = Workout(
  title: 'Staggered Push-ups',
  steps: [
    'Assume a standard push-up position with legs and arms straight. Hands under shoulders.',
    'Next, stagger your hands by placing your right hand forward and left hand back. This is the starting position.',
    'Begin exercise by lowering your chest until it almost touches the ground. Pause, then push back up as quickly as possible. This completes one rep. Alternate hands every set.'
  ],
  videoLink:
  'https://www.youtube.com/watch?v=odAdPR3ypSs&ab_channel=Exercises.com.au',
  showTimer: false,
  intermediateRap: 12,
  advanceRap: 16,
  imageSrc: 'assets/all-workouts/staggeredPushUps.gif',
);
Workout ployMetricPushUps = Workout(
  title: 'PloyMetric Push-ups',
  steps: [
    'Start in a high plank, or at the top of pushup position. Your torso should be in a straight line, core engaged (tightened), and palms directly under your shoulders.',
    'Start to lower your body as if you’re going to do a pushup until your chest is almost touching the floor.',
    'As you push up, do so with enough force for your hands to leave the ground. For added difficulty, you can clap your hands together, but this is optional.',
    'Land lightly on the ground, moving into your next rep immediately.'
  ],
  videoLink:
  'https://www.youtube.com/watch?v=Z1hBVYb3Gi0&ab_channel=ThePostGame',
  showTimer: false,
  intermediateRap: 12,
  advanceRap: 16,
  imageSrc: 'assets/all-workouts/polymetriPushUps.gif',
);
Workout hinduPushUps2 = Workout(
  title: 'Hindu Push-ups',
  steps: [
    'Assume a push-up position with your feet hip-width apart. Keep your core tight and back flat.',
    'Push your torso backward and raise your butt up to move into a pike position so your body forms an inverted V.',
    'Bend your elbows to lower your upper chest to the ground while keeping your butt up. As you lower your chest, drop your butt down so your body is in a straight line when you\'re closest to the ground.',
    'Straighten your arms to push your chest up, but allow for a slight arch in your back similar to the yoga Upward Dog position.'
  ],
  videoLink: 'https://www.youtube.com/watch?v=nBLy1IGtSJ8&ab_channel=AnyUp',
  showTimer: false,
  intermediateRap: 10,
  advanceRap: 12,
  imageSrc: 'assets/all-workouts/hinduPushUps.gif',
);
Workout staggeredPushUps2 = Workout(
    title: 'Staggered Push-ups',
    steps: [
      'Assume a standard push-up position with legs and arms straight. Hands under shoulders.',
      'Next, stagger your hands by placing your right hand forward and left hand back. This is the starting position.',
      'Begin exercise by lowering your chest until it almost touches the ground. Pause, then push back up as quickly as possible. This completes one rep. Alternate hands every set.'
    ],
    videoLink:
    'https://www.youtube.com/watch?v=odAdPR3ypSs&ab_channel=Exercises.com.au',
    showTimer: false,
    intermediateRap: 10,
    advanceRap: 12,
    imageSrc: 'assets/all-workouts/staggeredPushUps.gif');
Workout ployMetricPushUps2 = Workout(
  title: 'PloyMetric Push-ups',
  steps: [
    'Start in a high plank, or at the top of pushup position. Your torso should be in a straight line, core engaged (tightened), and palms directly under your shoulders.',
    'Start to lower your body as if you’re going to do a pushup until your chest is almost touching the floor.',
    'As you push up, do so with enough force for your hands to leave the ground. For added difficulty, you can clap your hands together, but this is optional.',
    'Land lightly on the ground, moving into your next rep immediately.'
  ],
  videoLink:
  'https://www.youtube.com/watch?v=Z1hBVYb3Gi0&ab_channel=ThePostGame',
  showTimer: false,
  intermediateRap: 10,
  advanceRap: 12,
  imageSrc: 'assets/all-workouts/polymetriPushUps.gif',
);
Workout declinePushUps = Workout(
    title: 'Decline Push-Ups',
    steps: [
      'Kneel down with your back to the bench. Put your hands on the floor, shoulders over your wrists and elbows at 45 degrees.',
      'Place your feet on top of the bench.',
      'Brace your core, glutes, and quads.',
      'Bend your elbows and lower your chest to the floor, keeping your back and neck straight.',
      'Push into the floor to return to starting position, extending your elbows.',
    ],
    videoLink:
    'https://www.youtube.com/watch?v=b_CC4kAF1HQ&ab_channel=LIVESTRONG.COM',
    showTimer: false,
    intermediateRap: 12,
    advanceRap: 16,
    imageSrc: 'assets/all-workouts/declinePushUps.gif');
Workout walkingPlank = Workout(
    title: 'Walking Plank',
    steps: [
      'Get into high plank position with hands directly under the shoulders.',
      'Walk right hand forward as far as possible',
      'then bring left hand to meet it',
      'Step left hand back to start, then right hand.',
    ],
    videoLink:
    'https://www.youtube.com/watch?v=1mPOD3IZxlI&ab_channel=NationalAcademyofSportsMedicine%28NASM%29',
    showTimer: false,
    advanceRap: 16,
    intermediateRap: 12,
    beginnerRap: 8,
    imageSrc: 'assets/all-workouts/walkingPlank.gif');
Workout shoulderStretch = Workout(

  title: 'Shoulder Stretch',
  imageSrc: "assets/all-workouts/shoulder_stretch.gif",

  steps: [
    'Bring one arm across your upper body and hold it straight.',
    'Grasp the elbow with the other arm and gently pull toward your chest.',
    'Hold for 5to 10 seconds and repeat on the other side.',
  ],
  videoLink:
  'https://www.youtube.com/watch?v=KNfqxl7jkiU&ab_channel=NHSAyrshire%26Arran',
  showTimer: true,
  duration: 30,
);
Workout burpee = Workout(
  title: 'Burpee',
  steps: [
    'Bend over or squat down and place your hands on the ground in front of you, shoulder-width apart.',
    'Jump back so that you end up in a plank.',
    'Drop down to a pushup until your chest touches the floor.',
    'Push up to return to the plank again.',
    'Spring back, placing your feet back in the original position in line with your hands.',
    'Now jump explosively. Reach your arms overhead.'
  ],
  videoLink: 'https://www.youtube.com/watch?v=G2hv_NYhM-A&ab_channel=BuiltLean',
  showTimer: false,
  advanceRap: 12,
  intermediateRap: 10,
  imageSrc: 'assets/all-workouts/burpee.gif',
);
Workout legBurpee = Workout(
  title: 'Burpee',
  steps: [
    'Bend over or squat down and place your hands on the ground in front of you, shoulder-width apart.',
    'Jump back so that you end up in a plank.',
    'Drop down to a push-up until your chest touches the floor.',
    'Push up to return to the plank again.',
    'Spring back, placing your feet back in the original position in line with your hands.',
    'Now jump explosively. Reach your arms overhead.'
  ],
  videoLink: 'https://www.youtube.com/watch?v=G2hv_NYhM-A&ab_channel=BuiltLean',
  showTimer: false,
  advanceRap: 14,
  intermediateRap: 10,
  imageSrc: 'assets/all-workouts/burpee.gif',
);
Workout diamond2 = Workout(
  title: 'Diamond Push-Ups',
  steps: [
    'Get on all fours with your hands together under your chest.',
    'Position your index fingers and thumbs so they’re touching, forming a diamond shape, and extend your arms so that your body is elevated and forms a straight line from your head to your feet.',
    'Lower your chest towards your hands, ensuring you don’t flare your elbows out to the sides and keeping your back flat.',
    'Stop just before your chest touches the floor, then push back up to the starting position.'
  ],
  videoLink: 'https://www.youtube.com/watch?v=pD3mD6WgykM&ab_channel=Howcast',
  showTimer: false,
  advanceRap: 12,
  intermediateRap: 10,
  imageSrc: 'assets/all-workouts/diamond.gif',
);
Workout diamond = Workout(
  title: 'Diamond Push-Ups',
  steps: [
    'Get on all fours with your hands together under your chest.',
    'Position your index fingers and thumbs so they’re touching, forming a diamond shape, and extend your arms so that your body is elevated and forms a straight line from your head to your feet.',
    'Lower your chest towards your hands, ensuring you don’t flare your elbows out to the sides and keeping your back flat.',
    'Stop just before your chest touches the floor, then push back up to the starting position.'
  ],
  videoLink: 'https://www.youtube.com/watch?v=pD3mD6WgykM&ab_channel=Howcast',
  showTimer: false,
  advanceRap: 16,
  intermediateRap: 12,
  imageSrc: 'assets/all-workouts/diamond.gif',
);
Workout spiderManPushUps = Workout(
  title: 'Spider-Man Push-Ups',
  imageSrc: 'assets/all-workouts/spiderMan.gif',
  steps: [
    'Start in a plank position, your hands slightly wider than shoulder-distance apart, but directly under your shoulders. Your body should form a straight line from heels to head.',
    'Tighten your core and begin bending your elbows, so they angle backward at 45-degrees from your body as you lower your chest toward the floor. Inhale as you move through the lowering phase of the exercise.',
    'Pick up your right foot and draw your right knee up and out, so your right knee reaches your elbow just as your chest hovers about an inch or two from the mat.',
    'Reverse the movement, extending your elbows to press up to the plank position as you simultaneously extend your knee and return your right foot to the floor. Exhale as you press yourself back to the starting position.',
    'Repeat to the opposite side, this time bringing your left knee to your left elbow.'
  ],
  videoLink:
  'https://www.youtube.com/watch?v=ND72B0DcYsQ&ab_channel=PrecisionMovementbyEricWong',
  showTimer: false,
  advanceRap: 16,
);

// -----------------------------------CHEST------------------------------------------
List<Workout> chestBeginner = [
  jumpingJacks,
  kneePushUps,
  inclinePushUps,
  tricepsDips,
  pushUps,
  kneePushUps2,
  tricepsDips2,
  pushUps2,
  walkingPlank,
  chestStretch,
  cobraStretch,
];

List<Workout> chestIntermediate = [
  jumpingJacks,
  armCircleClockWise,
  pushUps,
  wideArmPushUps,
  hinduPushUps,
  staggeredPushUps,
  ployMetricPushUps,
  pushUps2,
  hinduPushUps2,
  staggeredPushUps2,
  ployMetricPushUps2,
  declinePushUps,
  walkingPlank,
  cobraStretch,
  chestStretch
];

List<Workout> chestAdvance = [
  jumpingJacks,
  armCircleClockWise,
  shoulderStretch,
  ployMetricPushUps,
  burpee,
  hinduPushUps,
  staggeredPushUps,
  diamond,
  pushUps,
  staggeredPushUps2,
  spiderManPushUps,
  hinduPushUps2,
  declinePushUps,
  burpee,
  walkingPlank,
  shoulderStretch,
  cobraStretch,
  chestStretch
];

//-------------------------------------ABS--------------------------------------

List<Workout> absBeginner = [
  beginnerJumpingJacks,
  abdominalCrunches,
  russianTwist,
  flutterKikes,
  pulseUp,
  mountainClimbing,
  russianTwist2,
  elbowPlanks,
  abdominalCrunches2,
  pulseUp2,
  flutterKikes2,
  mountainClimbing2,
  wipers,
  spineLumberL,
  spineLumberR,
  cobraStretch,

];

List<Workout> absIntermediate = [
  jumpingJacks,
  reverseCrunches,
  mountainClimbing,
  tricepsDips,
  abdominalCrunches,
  russianTwist,
  vUps,
  sidePlankRight,
  sidePlankLeft,
  tricepsDips,
  russianTwist2,
  mountainClimbing2,
  reverseCrunches2,
  vUps2,
  abdominalCrunches2,
  sidePlankRight2,
  sidePlankLeft2,
  spineLumberL,
  spineLumberR,
  cobraStretch,
];

List<Workout> absAdvance = [
  jumpingJacks,
  tricepsDips,
  sidePlankLeft,
  sidePlankRight,
  reverseCrunches,
  vUps,
  pushUpsRotation,
  abdominalCrunches,
  russianTwist,
  reverseCrunches2,
  tricepsDips2,
  flutterKikes,
  abdominalCrunches2,
  vUps2,
  russianTwist2,
  flutterKikes2,
  walkingPlank,
  advanceElbowPlanks,
  wipers,
  cobraStretch,
  spineLumberL,
  spineLumberR,
];

//------------------------------------Shoulder----------------------------------

List<Workout> shoulderBeginner = [
  jumpingJacks,
  armCircleClockWise,
  rhomboidPulls,
  sideArmRaise,
  kneePushUps,
  inchWorm,
  reclinedRhomboidSqueezes,
  threadTheNeedleL,
  threadTheNeedleR,
  armScissors,
  rhomboidPulls2,
  sideArmRaise2,
  kneePushUps2,
  reclinedRhomboidSqueezes2,
  catCowPose,
  childPose,
];

List<Workout> shoulderIntermediate = [
  jumpingJacks,
  tricepsDips,
  inclinePushUps,
  rhomboidPulls,
  floorTricepsDips,
  catCowPose,
  diamond2,
  inclinePushUps2,
  plankUp,
  sideArmRaise,
  floorTricepsDips2,
  inchWorm,
  pulseUp2,
  threadTheNeedleL,
  threadTheNeedleR,
  childPose,
];

List<Workout> shoulderAdvance = [
  jumpingJacks,
  floorTricepsDips,
  pikePushUps,
  reversePushUps,
  threadTheNeedleL,
  threadTheNeedleR,
  floorTricepsDips2,
  pikePushUps2,
  reversePushUps2,
  catCowPose,
  plankUp,
  inchWorm,
  wideArmPushUps,
  reverseSnowAngle,
  plankUp2,
  inchWorm2,
  wideArmPushUps,
  reverseSnowAngle,
  childPose,
];

//-----------------------------------Legs---------------------------------------

List<Workout> legsBeginner = [
  jumpingJacks,
  squats,
  squats,
  bottomLegLiftLeft,
  bottomLegLiftRight,
  bottomLegLiftLeft,
  bottomLegLiftRight,
  lateralSquat,
  lateralSquat,
  fireHydrantLeft,
  fireHydrantRight,
  fireHydrantLeft,
  fireHydrantRight,
  leftQuadStretch,
  rightQuadStretch,
  kneeToChestStretch,
  kneeToChestStretch,
  wallResistingSingleLegLeft,
  wallResistingSingleLegRight,
  sumoSquat,
  sumoSquat,
  calfStretchLeft,
  calfStretchRight,
];

List<Workout> legsIntermediate = [
  jumpingJacks,
  squats,
  squats,
  squats,
  bottomLegLiftLeft,
  bottomLegLiftRight,
  bottomLegLiftLeft,
  bottomLegLiftRight,
  bottomLegLiftLeft,
  bottomLegLiftRight,
  lateralSquat,
  lateralSquat,
  buttBridge,
  buttBridge,
  buttBridge,
  sumoSquat,
  sumoSquat,
  fireHydrantLeft,
  fireHydrantRight,
  fireHydrantLeft,
  fireHydrantRight,
  leftQuadStretch,
  rightQuadStretch,
  lyingButterFlyStretch,
  walkingLunges,
  walkingLunges,
  walkingLunges,
  wallResistingSingleLegLeft,
  wallResistingSingleLegRight,
  wallResistingSingleLegLeft,
  wallResistingSingleLegRight,
  calfStretchLeft,
  calfStretchRight
];

List<Workout> legsAdvance = [
  jumpingJacks,
  curtsyLunges,
  curtsyLunges,
  curtsyLunges,
  bottomLegLiftLeft,
  bottomLegLiftRight,
  bottomLegLiftLeft,
  bottomLegLiftRight,
  bottomLegLiftLeft,
  bottomLegLiftRight,
  sumoSquat,
  sumoSquat,
  sumoSquat,
  fireHydrantLeft,
  fireHydrantRight,
  fireHydrantLeft,
  fireHydrantRight,
  fireHydrantLeft,
  fireHydrantRight,
  legBurpee,
  legBurpee,
  jumpingSquats,
  jumpingSquats,
  jumpingSquats,
  lateralSquat,
  lateralSquat,
  lateralSquat,
  wallSit,
  wallSit,
  leftQuadStretch,
  rightQuadStretch,
  walkingLunges,
  walkingLunges,
  walkingLunges,
  lyingButterFlyStretch,
  wallResistingSingleLegLeft,
  wallResistingSingleLegRight,
  wallResistingSingleLegLeft,
  wallResistingSingleLegRight,
  wallResistingSingleLegLeft,
  wallResistingSingleLegRight,
  calfStretchLeft,
  calfStretchRight,
];

//---------------------------------Arms-----------------------------------------\

//  Body saw -->>>  leg barbell curl
List<Workout> armsBeginner = [
  jumpingJacks,
  sideArmRaise,
  tricepsDips,
  armCircleClockWise,
  armCircleCounterClockWise,
  pulseUp,
  sideArmRaise2,
  inchWorm,
  diagonalPlank,
  punches2,
  pushUps,
  inchWorm,
  wallPushUps,
  tricepsStretchLeft,
  tricepsStretchRight,
  standingBicepsStretchLeft,
  standingBicepsStretchRight
];

List<Workout> armsIntermediate = [
  armCircleClockWise,
  armCircleCounterClockWise,
  tricepsPushUp,
  floorTricepsDips,
  punches,
  pushUpsRotation,
  armCurlsCrunchLeft,
  armCurlsCrunchRight,
  floorTricepsDips2,
  tricepsPushUp2,
  pushUpsRotation2,
  armCurlsCrunchLeft,
  armCurlsCrunchRight,
  skippingWithOutRope,
  pushUps,
  burpee,
  armScissors,
  skippingWithOutRope,
  pushUps2,
  burpee,
  tricepsStretchLeft,
  tricepsStretchRight,
  standingBicepsStretchLeft,
  standingBicepsStretchRight,
];

List<Workout> armsAdvance = [
  //ToDo: remove all comments
  // armCircleClockWise,
  // armCircleCounterClockWise,
  // skippingWithOutRope,
  // burpee,
  // armCurlsCrunchLeft,
  // armCurlsCrunchRight,
  // declinePushUps,
  // floorTricepsDips,
  // punches,
  // tricepsPushUp,
  // tricepsDips,
  // floorTricepsDips2,
  // declinePushUps,
  // punches2,
  // burpee,
  // armCurlsCrunchLeft2,
  // armCurlsCrunchRight2,
  // tricepsPushUp2,
  // tricepsDips2,
  // threadTheNeedleL,
  // threadTheNeedleR,
  // wideArmPushUps,
  // inchWorm2,
  // pushUpsRotation,
  // tricepsStretchLeft,
  tricepsStretchRight,
  standingBicepsStretchLeft,
  standingBicepsStretchRight
];

List<Workout> workoutList = [
  armCurlsCrunchLeft,
  armCurlsCrunchLeft2,
  armCurlsCrunchRight,
  armCurlsCrunchRight2,
  skippingWithOutRope,
  tricepsPushUp,
  tricepsPushUp2,
  armCircleClockWise,
  armCircleCounterClockWise,
  diagonalPlank,
  punches,
  punches2,
  wallPushUps,
  tricepsStretchLeft,
  tricepsStretchRight,
  standingBicepsStretchRight,
  standingBicepsStretchLeft,
  kneeToChestStretch,
  squats,
  buttBridge,
  curtsyLunges,
  bottomLegLiftLeft,
  bottomLegLiftRight,
  sumoSquat,
  fireHydrantLeft,
  fireHydrantRight,
  jumpingSquats,
  wallSit,
  leftQuadStretch,
  rightQuadStretch,
  wallResistingSingleLegLeft,
  wallResistingSingleLegRight,
  lyingButterFlyStretch,
  walkingLunges,
  lateralSquat,
  calfStretchLeft,
  calfStretchRight,
  rhomboidPulls,
  sideArmRaise,
  reclinedRhomboidSqueezes,
  armScissors,
  rhomboidPulls2,
  sideArmRaise2,
  reclinedRhomboidSqueezes2,
  floorTricepsDips,
  pikePushUps,
  reversePushUps,
  threadTheNeedleL,
  threadTheNeedleR,
  floorTricepsDips2,
  pikePushUps2,
  reversePushUps2,
  catCowPose,
  plankUp,
  inchWorm,
  plankUp2,
  reverseSnowAngle,
  childPose,
  inchWorm2,
  abdominalCrunches,
  russianTwist,
  flutterKikes,
  pulseUp,
  mountainClimbing,
  russianTwist2,
  elbowPlanks,
  advanceElbowPlanks,
  abdominalCrunches2,
  flutterKikes2,
  mountainClimbing2,
  pulseUp2,
  wipers,
  reverseCrunches,
  vUps,
  sidePlankRight,
  sidePlankLeft,
  vUps2,
  reverseCrunches2,
  sidePlankRight2,
  sidePlankLeft2,
  pushUpsRotation,
  pushUpsRotation2,
  spineLumberL,
  spineLumberR,
  jumpingJacks,
  kneePushUps,
  inclinePushUps,
  inclinePushUps2,
  tricepsDips,
  pushUps,
  kneePushUps2,
  tricepsDips2,
  pushUps2,
  cobraStretch,
  chestStretch,
  hinduPushUps,
  wideArmPushUps,
  staggeredPushUps,
  ployMetricPushUps,
  hinduPushUps2,
  staggeredPushUps2,
  ployMetricPushUps2,
  declinePushUps,
  walkingPlank,
  shoulderStretch,
  burpee,
  legBurpee,
  diamond2,
  diamond,
  spiderManPushUps
];
List<Workout> allWorkOut = [
  ...absAdvance,
  ...absBeginner,
  ...absIntermediate,
  ...legsAdvance,
  ...legsBeginner,
  ...legsIntermediate,
  ...chestAdvance,
  ...chestBeginner,
  ...chestIntermediate,
  ...shoulderAdvance,
  ...shoulderBeginner,
  ...shoulderIntermediate,
  ...armsAdvance,
  ...armsBeginner,
  ...armsIntermediate
];
