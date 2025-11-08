# Equipment Management System API Documentation

## Authentication APIs

### 1. Register Student
- **Endpoint:** `POST /api/auth/signup`
- **Role:** Public
- **Request Body:**
```json
{
    "username": "string",
    "password": "string",
    "full_name": "string",
    "prn_number": "string"
}
```
- **Response:**
```json
{
    "user_id": "number",
    "username": "string",
    "role": "student",
    "message": "string",
    "token": "string"
}
```

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