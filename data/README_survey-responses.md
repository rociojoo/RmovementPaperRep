R tracking package survey
=========================


Introduction
------------

A survey was elaborated for R package users regarding:

  * How popular those packages are;
  * How well documented they are;
  * How relevant they are for users.

A total of 72 packages were investigated with the survey, all related
to movement analysis: acc, accelerometry, adehabitatHR, adehabitatHS,
adehabitatLT, amt, animalTrack, anipaths, argosfilter, argosTrack,
BayesianAnimalTracker, BBMM, bcpa, bsam, caribou, crawl, ctmcmove,
ctmm, diveMove, drtracker, EMbC, feedR, FLightR, GeoLight, GGIR, hab,
HMMoce, Kftrack, m2b, marcher, migrateR, mkde, momentuHMM, move,
moveHMM, movement, movementAnalysis, moveNT, moveVis, moveWindSpeed,
nparACT, pathtrackr, pawacc, PhysicalActivity, probgls, rbl, recurse,
rhr, rpostgisLT, rsMove, SDLfilter, SGAT/TripEstimation, sigloc,
SimilarityMeasures, SiMRiv, smam, SwimR, T-LoCoH, telemetr, trackdem,
trackeR, Trackit, TrackReconstruction, TrajDataMining, trajectories,
trip, TwGeos/BAStag, TwilightFree, Ukfsst/kfsst, VTrack and
wildlifeDI. More details on https://mablab.org/post/r-move-survey-1/
and Joo et al. (pre-print at https://arxiv.org/abs/1901.05935). Two
packages were missed by the survey (not identified on time) but are in
the updated version of the manuscript: lsmnsd and segclust2d.


Participation in the survey
---------------------------

The survey was designed to be completely anonymous, meaning that we
had no way to know who participated and not even the date of
participation was saved. There was no previous selection of the
participants and no probabilistic sampling was involved. The survey
was advertised by Twitter, mailing lists (r-sig-geo and
r-sig-ecology), individual emails to researchers and the [MabLab
website](https://mablab.org/post/2018-08-31-r-movement-review/).

The survey got exemption from the Institutional Review Board at
University of Florida (IRB02 Office, Box 112250, University of
Florida, Gainesville, FL 32611-2250).

A total of 446 people participated in the survey, and 233 answered all
four questions. To answer all questions the participant had to have
tried at least one of the packages.

The survey file contains the anonymous answers. One row per
participant.

* Column "id" is an ID number for the participant.
* "completion" gives the percentage of survey completion by the
  participant. NA means that they did not even responded to the first
  question
* columns starting with "q1" (one column per package) are related to
  the first question: How often do you use each of these packages?
  (Never, Rarely, Sometimes, Often).
* columns starting with "q2" (one column per package) are related to
  the second question: How helpful is the documentation provided for
  each of the packages you've used for your work? Documentation
  includes what is contained in the manual and help pages, vignettes,
  published manuscripts, and other material about the package provided
  by the authors.  Please answer using one of the following options:
    - Not enough: It's not enough to let me know how to do what I
      need;
    - Basic: It's enough to let me get started with simple use of the
      functions but not to go further (e.g. use all arguments in the
      functions, or put extra variables);
    - Good: I did everything I wanted and needed to do with it;
    - Excellent: I ended up doing even more than what I planned
      because of the excellent information in the documentation.
    - Don't remember: I honestly can't remember… 
* columns starting with "q3" (one column per package) are related to
the third question: How relevant is each of the packages you've used
for your work?  Please answer using one of the following options:
    - Not relevant: I tried the package but really didn't find it a
      good use for my work;
    - Slightly relevant: It helps in my work, but not for the core of
      it;
    - Important: It's important for the core of my work, but if it
      didn't exist, there are other packages or solutions to obtain
      something similar;
    - Essential: I wouldn't have done the key part of my work without this package. 
* "q4" corresponds to the answers to the fourth question: What kind of
  R user do you consider yourself? Choose one of the following answers
    - Beginner: You only use existing packages and occasionally write
      some lines of code.
    - Intermediate: You use existing packages but you also write and
      optimize your own functions.
    - Advanced: You commonly use version control or contribute to
      develop packages.

