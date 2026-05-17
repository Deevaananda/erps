import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'CollegeERP.settings')
django.setup()

from info.models import User, Dept, Class, Student, Teacher

# Create a superuser for admin
admin = User.objects.create_superuser('admin', 'admin@college.com', 'project123')
print(f'✓ Created admin user: admin')

# Create a department
dept = Dept.objects.create(id='CS', name='Computer Science')
print(f'✓ Created department: {dept.name}')

# Create a class
class_obj = Class.objects.create(id='CS5A', dept=dept, sem=5, section='A')
print(f'✓ Created class: {class_obj}')

# Create a student user and student record
student_user = User.objects.create_user('samarth', 'samarth@college.com', 'project123', is_staff=False)
student = Student.objects.create(user=student_user, class_id=class_obj, USN='CS001', name='Samarth Patel')
print(f'✓ Created student: {student.name} (username: samarth)')

# Create a teacher user and teacher record
teacher_user = User.objects.create_user('trisila', 'trisila@college.com', 'project123', is_staff=False)
teacher = Teacher.objects.create(user=teacher_user, id='TECH001', name='Trisila Singh', dept=dept)
print(f'✓ Created teacher: {teacher.name} (username: trisila)')

print('\n✓ All users created successfully!')
print('\nLogin credentials:')
print('  Admin: username=admin, password=project123')
print('  Student: username=samarth, password=project123')
print('  Teacher: username=trisila, password=project123')
