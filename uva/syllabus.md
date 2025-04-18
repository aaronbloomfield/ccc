CS 4970: Syllabus for Cryptocurrency (CCC), spring 2025
=============================================

[Go up to the CCC UVA page](index.html) ([md](index.md))

This course is a general introduction to cryptocurrencies and blockchain applications.  Students will understand the theoretical concepts that underlay cryptocurrencies, and implement both their own cryptocurrencies as well as develop applications that run on existing cryptocurrencies.  Students will see the ethics, legality, and policy aspects pertaining to the subject.

## Quick version

I realize that nobody reads these through.  So the TL;DR version:

- Course staff: [Aaron Bloomfield](https://www.cs.virginia.edu/~asb) (aaron at virginia dot edu) and a group of amazing teaching assistants
- This course is using Canvas; the Canvas workspace is [here](https://canvas.its.virginia.edu/courses/93490)
- One midterm, on Wednesday, February 27th, during lecture; one final, on Friday, May 9th, from 9am - noon
- Grades are 45% homeworks, 20% midterm, 25% final exam, and 10% participation (quizzes & attendance)
- Everything is going to be auto-graded, but you can submit multiple times; the grades won't be known until the late due date has passed; there is going to be a reasonable limit on how many times you can submit (currently set to 10)
- If you encounter any rough spots in the course -- please be patient, and provide constructive feedback, and I'll do my best to get it all fixed quickly
- You can't use any generative AI product, such as ChatGPT, to write your code that you are going to submit; it turns out it's not all that useful due to the specialized nature of the assignments in this class; you may use it to help understand topics, understand code segments, etc., but it can't be any used to generate any of the code that you submit
- There will be both larger programming homeworks and smaller tutorial-style  homeworks or readings -- sometimes one of each will be assigned at any given time; large homeworks will be weighted at twice the weight of the smaller homeworks
- There is a flexible, but not infinite, late policy in this course -- you can submit up to 6 of them up to 4 days late with no penalty
- Lecture attendance is required, and occasional attendance quizzes will be taken to ensure that
- If you have to miss a day of class for a valid reason, fill out the appropriate form, the link to which is on the Canvas landing page
- Readings will typically have in-class quizzes when they are due
- Attendance quizzes and reading quizzes may be online, so bring a connected device (a phone is fine)
- Due to the size of the course, please contact us via the course email address; the link is on the Canvas landing page
- Office hours are posted on the Canvas landing page
- You are required to have a notebook or laptop computer for this course -- if you do not have one, let me know, and the department will loan you one.
- I want you to succeed in this course and enjoy it -- if you are having any problems (personal, academic, what-not) that I can help with, please let me know

----

## Long Version

And now for the really long-winded version...

### Course Staff ###

- Instructor: [Aaron Bloomfield](https://www.cs.virginia.edu/~asb) / aaron at virginia dot edu.  Office: Rice Hall, room 402.  Office hours are posted on the Canvas landing page, and will start the second week of the semester
- Multiple undergraduate TAs; their office hours are also posted on the Canvas landing page, and will start the second week of the semester

### Course Info ###

- Lecture: Tu/Th 11:00-12:15 in Thornton A120
- Coordination is through Canvas; the Canvas workspace is [here](https://canvas.its.virginia.edu/courses/140076)
- Email: the course email is listed on the Canvas landing page; please do not email the course staff directly
- Announcements will be done through the [daily announcements slide set](daily-announcements.html#/)
- TAs and their office hours will be posted on the Canvas landing page; all office hours start the second week of classes


**Course content:** All the course content is available free online at 
[http://aaronbloomfield.github.io/ccc](http://aaronbloomfield.github.io/ccc), which is from a public github repository: [https://github.com/aaronbloomfield/ccc](https://github.com/aaronbloomfield/ccc).  All the source code in that repository is released under a [GPL 3.0 license](https://www.gnu.org/licenses/gpl-3.0.en.html), and all the non-source code material in that repository is released under a [Creative Commons license](https://creativecommons.org/licenses/by-sa/4.0/) (CC BY-SA).  Note that this license and the public availability does NOT apply to the lecture videos.

**Lectures:** Lecture attendance is required.  There will be occasional attendance quizzes to verify this.  These quizzes may be online, so bring a connected device (phone is fine) to take said quizzes.

**Readings:** Due to the rapidly changing nature of this topic, there is no assigned textbook.  Various online readings will be assigned.  You should expect a reading quiz on the day that a reading is due.  These quizzes may be online, so bring a connected device (phone is fine) to take said quizzes.

**Purchases:** As mentioned above, no textbook is required for this course.  In particular, you will NOT have to purchase any cryptocurrency for this course. You don't have to purchase anything else for this course.  But you do have to have a relatively modern *notebook* computer.  If you do not have one, or yours breaks during the semester, speak to me as the department can loan you one.

**Course Description:** This course is meant as a general introduction to cryptocurrency.  This course is split into three "modules": introduction and Bitcoin, Ethereum and smart contracts, and Web3.

The course objectives are:

- Understand the theoretical aspects of cryptocurrency
- Understand the basics of blockchain in general, and the details of a selected number of blockchains
- Understand the uses of cryptocurrency and blockchain beyond that as a form of money
- Understand the policy, ethical, legal, and tax implications of cryptocurrency
- Be able to develop programs for a specific Blockchain
- Implement a fully working modern cryptocurrency

**Availability:** It is important to me to be available to my students, and to address their concerns. If you cannot meet with me during office hours, e-mail me and I will try to find the time to meet. That being said, like everybody else I am quite busy, so it may take a day or more to find a time to meet. And if you have any comments on the course - what is working, what is not working, what can be done better, etc. - I am very interested in hearing about them. There is an anonymous feedback tool through Canvas, or you can send me an e-mail (please do NOT email the TAs directly). I tend to get bogged down by e-mail as the semester progresses, so seeing me "in person" (during office hours or right after class) is often a good way to get a more immediate response.

**Prerequisites:** Three semesters of college-level computing classes.  This is typically CS 2150 (Program and Data Representation) or CS 3100 (Data Structures and Algorithms 2) with a grade of C- or above. Another programming class that requires CS 2100 as a pre-req is fine as well.  As per departmental policy, this pre-req will be checked, and if it is not met, you will be de-registered from the course.

**Grades:** Grades will be calculated by the following formula:

- Programming and written assignments (45%)
- Midterm (20%)
- Final exam (25%)
- Class attendance, reading quizzes (10%)

I *expect* that grades will follow the standard decade curve: 90 and above is an A of some sort (A-, A, or A+), 80 and above is some sort of a B, etc.  **Note:** I reserve the right to modify the weighting (changing the curve, adding pop quizzes, etc.), especially if attendance drops off significantly.  In particular, if the grade averages are very high, then you will need higher than a 90 to get an A-.

**Assignments:** There will be both larger programming homeworks and smaller tutorial-style homeworks.  Often one of each will be currently assigned at any given time, but their due dates will be scheduled so that they are not both due at once.  All assignments will be submitted via Gradescope.  Many assignments will require you to deploy your code to a private Ethereum blockchain in addition to the Gradescope submission.  The link to Gradescope is in the Canvas workspace.  Due to the class size, and the limited TA support, all assignments will be auto-graded.  The programming assignments will have their source code submitted.  You will need to be familiar with the [homework policies](hw-policies.html) ([md](hw-policies.md)), as you will be bound by them on the assignments.  You may submit an assignment multiple times, but only the most recent one will count.  There will be a reasonable limit to how many times you can submit (say, 10) -- this is to prevent people from using Gradescope as a debugger.

**Late policy:** There are expected to be 13 assignments this semester (12 P assignments, and 2 S assignments) -- the other few S assignments are readings and surveys.  The standard late penalty: 25% off per day (or fraction thereof).   You may submit 6 of them up to 4 days late with no penalty -- to do so, you have to fill out a form *before* the due date for this; it will be on the Canvas landing page.  After using your 6 free passes, the late penalty applies.  Note that this covers *ALL* circumstances: sick, busy, travel, dog ate your homework, family emergencies, etc.  And, generally, SDAC accommodations.  A few notes:

- There is no penalty for using all of them
- There is no bonus for not using some of them
- You have to submit the request (via the Google form) *BEFORE* the due date/time
- If you use them all early, and an emergency comes up, then you do not get any more extensions
- You can only use one per assignment
- After 4 free days, the standard late penalty applies


**Course rules:** You are fully responsible for all material presented in class and on the required readings. Exams and due dates are scheduled in advance. A grade of zero will be recorded for missed exams and late assignments unless prior arrangements are made (see below for details) or there are truly extenuating circumstances (which will require appropriate documentation). Assignments turned in after the due date are penalized 25% per day (or fraction thereof) late; this means a maximum of 3 days (i.e. 72 hours) late. A few assignments will allow you to choose the programming language to implement it in, but most will have a specified language that you have to use.  The Gradescope submission auto-grader will verify this upon submission (and immediately report the results back to you). Most assignments will be graded by automated testing.

**Disabilities:**  The University of Virginia strives to provide accessibility to all students. If you require an accommodation to fully access this course, please contact the Student Disability Access Center (SDAC) at (434) 243-5180 or sdac@virginia.edu. If you are unsure if you require an accommodation, or to learn more about their services, you may contact the SDAC at the number above or by visiting the student health website at [https://sdac.studenthealth.virginia.edu/](https://sdac.studenthealth.virginia.edu/).  How I handle disability accommodations can be seen [here](sdac.html) ([md](sdac.md)).  If you feel that you need additional steps for your accommodations, please get in touch with me so we can discuss it.

**Special Circumstances:** Students with special circumstances (athletics, extra time required on exams, final exam conflicts, SDAC considerations, etc.) need to let me know during the **first two weeks of class**.

**Exams:** There will be one midterm exam (worth 20% of the final grade) and one final exam (worth 25% of the final grade).

- Midterm exam: Wednesday, February 27th, during lecture
- Final exam: Friday, May 9th, from 9am - noon

Under **NO** circumstances will anybody be allowed to take the final exam early.  You may **ONLY** request to take the final exam at a different time if you have a final exam **CONFLICT**, not a busy final exam schedule.  Since there are no other exams scheduled during that time, it is unlikely that you will have a conflict.

**Regrades:** You may submit graded homeworks and exams for regrading within one week of when they are returned to you (less time for the final due to the end of the semester).  Regrades are submitted via Gradescope for written assignments, or via another method yet-to-be-announced for programming assignments.  As long as people submit responsibly, I will not institute a frivolous regrade policy that existed in some semesters of CS 2150 (if one is instituted, you will be told of this ahead of time).  This time limit will be strictly enforced.

**Generative Artificial Intelligence Usage:** You many use any generative AI product, such as ChatGPT, with the following caveat: none of the program code, nor written essays (if applicable) that you submit may have been created with the generative AI.  Thus, you can use it to understand how to use a function, explain how something works, etc.  But the products that you submit (code, essays, etc.) must be your own work.

**Honor pledge:** The UVA Honor Code is in effect for this course.  There is one course specific addition: You may not look at any other student's code for ANY reason, period.  Not to debug, not to help, not to learn.  You may not let another student look at *your* code for any reason.  Needless to say, you cannot copy code from online sources unless the assignment specifically allows it (and in those cases, you must cite your source).  The next paragraph describes this more.

Students are encouraged to discuss programs and assignments in general. However, helping others find bugs in existing programs, using another person's code, or writing code for someone else is cheating and a violation of the University's Honor System. Basically, you should not be looking at another person's code for **ANY** reason (obviously you can after BOTH have submitted the assignment, or if there is a group project). This includes consulting programming solutions to assignments from previous years. This also includes looking up solutions online.  Any honor violation or cheating will be referred to the honor committee, and will result in an *immediate failure for the course*, regardless of the outcome of the honor trial or your other grades. No exceptions! I am very strict on this, and one have successfully raised honor charges against students in the past due to violations of this policy - and I've blocked people from graduation because of honor offenses.

**Religious accommodations:** Students who wish to request academic accommodation for a religious observance should submit their request to me by email as far in advance as possible. I will grant any and all reasonable religious accommodations, but if it requires me to change something (exam proctoring, assignment due dates, etc.), I need to have some advance notice so that I can take care of it in time.  Students who have questions or concerns about academic accommodations for religious observance or religious beliefs may contact the University's Office for Equal Opportunity and Civil Rights (EOCR) at UVAEOCR@virginia.edu or 434-924-3200.

**Your Well Being:** The Engineering School proudly serves as a safe space for its students and aims to promote their well being. If you are feeling overwhelmed, stressed, or isolated, there are many individuals here who are ready and wanting to help.   In addition to the course instructors, you can seek help through the Engineering Undergraduate office (Thornton A122), or Courtney MacMasters (xar7nf, 243-5180) who is the SDAC accessibility specialist in the Engineering school.

Alternatively, there are also other University of Virginia resources available. The Student Health Center offers Counseling and Psychological Services (CAPS) for its students. Call 434-243-5150 (or 434-972-7004 for after hours and weekend crisis assistance) to get started and schedule an appointment. If you prefer to speak anonymously and confidentially over the phone, call Madison House's HELP Line at any hour of any day: 434-295-8255.

If you or someone you know is struggling with gender, sexual, or domestic violence, there are many community and University of Virginia resources available. The Office of the Dean of Students, Sexual Assault Resource Agency (SARA), Shelter for Help in Emergency (SHE), and UVA Women's Center are ready and eager to help. Contact the Director of Sexual and Domestic Violence Services at 434-982-2774.

**Legality:** This course has received approval from the necessary parts of UVA: [ITS](https://virginia.service-now.com/its/), [InfoSec](https://security.virginia.edu/), and the [Office of the University Counsel](https://universitycounsel.virginia.edu/).  Specifically, the cryptocurrencies created in this course will be exchangeable with each other, but not exchangeable with any cryptocurrency outside the course; thus they have no monetary value.  Because they have no monetary value, and because the activities in this course are necessary to achieve the academic goals of the course, these various activities of this course, including mining, have been judged to be legal under both Virginia state law and UVA's [Acceptable Use Policy](https://uvapolicy.virginia.edu/policy/IRM-002).
