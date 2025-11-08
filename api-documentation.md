# Equipment Management System API Documentation

## Authentication APIs — Signup (Student or Staff)

### Register (Student or Staff)
- **Endpoint:** `POST /api/auth/signup`
- **Role:** Public
- **Purpose:** User chooses to register either as a student or as staff. Registration validates:
  - Students against RegisteredStudents.prn_number
  - Staff against registeredstaff.email

- **Request Body (student):**
```json
{
  "username": "string",
  "password": "string",
  "full_name": "string",
  "prn_number": "string",
  "user_type": "student"
}
```

- **Request Body (staff):**
```json
{
  "username": "string",
  "password": "string",
  "full_name": "string",
  "email": "string",
  "user_type": "staff"
}
```

- **Behavior / Validation:**
  - If user_type === "student":
    - prn_number is required.
    - prn_number must exist in RegisteredStudents table.
    - prn_number must not already be claimed in user_data.prn_number.
  - If user_type === "staff":
    - email is required.
    - email must exist in registeredstaff table.
    - email must not already be claimed in user_data.email.
  - username must be unique.
  - Password is hashed (bcrypt) before storage.
  - Role saved as `student` or `staff` in user_data.role.

- **Success Response (201):**
```json
{
  "user_id": 123,
  "username": "jdoe",
  "role": "student",
  "message": "User registered successfully as student.",
  "token": "jwt.token.here"
}
```

- **Common Error Responses:**
  - 400 Bad Request — missing required fields or username already exists.
  - 401 Unauthorized — PRN/email not found in RegisteredStudents/registeredstaff.
  - 409 Conflict — PRN/email already registered.
  - 500 Server Error — unexpected server/database error.

### 2. Login
- **Endpoint:** `POST /api/auth/login`
- **Role:** Public
- **Request Body:**
```json
{
    "username": "string",
    "password": "string"
}
```
- **Response:**
```json
{
    "token": "string",
    "user_id": "number",
    "username": "string",
    "role": "string"
}
```

## Equipment Routes (`/api/equipment`)

### 1. List Equipment
- **Endpoint:** `GET /api/equipment`
- **Role:** Public
- **Query Parameters:** 
```json
{
    "category_id": "number (optional)",
    "search": "string (optional)"
}
```
- **Response:**
```json
[
    {
        "equipment_id": "number",
        "name": "string",
        "category_name": "string",
        "total_quantity": "number",
        "available_quantity": "number",
        "condition": "string"
    }
]
```

### 2. Add Equipment
- **Endpoint:** `POST /api/equipment`
- **Role:** Admin Only
- **Request Body:**
```json
{
    "name": "string",
    "category_id": "number",
    "total_quantity": "number",
    "condition": "string"
}
```
- **Response:**
```json
{
    "equipment_id": "number",
    "message": "string",
    "name": "string",
    "category_id": "number",
    "total_quantity": "number",
    "available_quantity": "number",
    "condition": "string"
}
```

### 3. Update Equipment
- **Endpoint:** `PUT /api/equipment/:id`
- **Role:** Admin Only
- **Request Body:**
```json
{
    "name": "string",
    "category_id": "number",
    "total_quantity": "number",
    "condition": "string"
}
```
- **Response:**
```json
{
    "message": "string",
    "equipment_id": "number"
}
```

### 4. Delete Equipment
- **Endpoint:** `DELETE /api/equipment/:id`
- **Role:** Admin Only
- **Response:**
```json
{
    "message": "string"
}
```

## Request Routes (`/api/requests`)

### 1. Create Request
- **Endpoint:** `POST /api/requests`
- **Role:** Authenticated Users
- **Request Body:**
```json
{
    "equipment_id": "number",
    "quantity": "number",
    "admin_notes": "string",
    "return_date": "date"
}
```
- **Response:**
```json
{
    "request_id": "number",
    "message": "string"
}
```

### 2. List Requests
- **Endpoint:** `GET /api/requests`
- **Role:** 
  - Students: See only their requests
  - Staff/Admin: See all requests
- **Response:**
```json
[
    {
        "request_id": "number",
        "requested_by": "string",
        "equipment_name": "string",
        "category_name": "string",
        "status": "string",
        "quantity": "number",
        "return_date": "date"
    }
]
```

### 3. Approve Request
- **Endpoint:** `PUT /api/requests/:id/approve`
- **Role:** Staff/Admin
- **Response:**
```json
{
    "message": "string"
}
```

### 4. Reject Request
- **Endpoint:** `PUT /api/requests/:id/reject`
- **Role:** Staff/Admin
- **Response:**
```json
{
    "message": "string"
}
```

### 5. Issue Equipment
- **Endpoint:** `PUT /api/requests/:id/issue`
- **Role:** Staff/Admin
- **Response:**
```json
{
    "message": "string"
}
```

### 6. Return Equipment
- **Endpoint:** `PUT /api/requests/:id/return`
- **Role:** Staff/Admin
- **Response:**
```json
{
    "message": "string"
}
```