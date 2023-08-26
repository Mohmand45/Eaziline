class GradeUtils {
  static String calculateGrade(int attendanceCount) {
    if (attendanceCount >= 90) {
      return 'A+';
    } else if (attendanceCount >= 80) {
      return 'A';
    } else if (attendanceCount >= 70) {
      return 'B+';
    } else if (attendanceCount >= 60) {
      return 'B';
    } else if (attendanceCount >= 50) {
      return 'C+';
    } else if (attendanceCount >= 40) {
      return 'C';
    } else if (attendanceCount >= 30) {
      return 'D+';
    } else if (attendanceCount >= 20) {
      return 'D';
    } else {
      return 'F';
    }
  }
}
