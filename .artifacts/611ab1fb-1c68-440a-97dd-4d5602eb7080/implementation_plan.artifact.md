# Implementation Plan - Refactor to Booking Website & Code Cleanup

Transform the platform into a streamlined, high-performance **Booking Website** for Bidaya Academy. This involves removing unnecessary "app-like" features to focus on a clean landing page experience and a robust WhatsApp booking flow.

## User Review Required

> [!IMPORTANT]
> **Feature Removal**: To achieve the "just a website" feel, I will remove:
> - **Internal Notifications**: The bell icon and unread badges.
> - **Student Dashboard ("Masari")**: Since bookings happen on WhatsApp, internal progress tracking is no longer needed.
> - **Scheduling Logic**: Internal calendar scheduling will be replaced by the direct owner contact flow.
> - **Splash Screen Redirects**: We will keep the Splash screen for branding, but simplify the initial navigation.

## Proposed Changes

### 1. Code Simplification & Cleanup

#### [MODIFY] [main.dart](file:///C:/Users/moham/StudioProjects/amr/lib/main.dart)
*   Remove unused routes: `/dashboard`, `/teacher-dashboard`, `/notifications`.
*   Keep routes for: `/`, `/about`, `/teachers`, `/courses`, `/course/:id`, `/login`, `/signup`.

#### [MODIFY] [auth_repository.dart](file:///C:/Users/moham/StudioProjects/amr/lib/features/auth/data/auth_repository.dart)
*   Remove session tracking and notification logic.
*   Keep Teacher profile management (Bio, Expertise, Price).

#### [DELETE] [Features & Folders]
*   Delete `lib/features/notifications/`
*   Delete `lib/features/dashboard/`
*   Delete `lib/features/sessions/` (excluding the shared model if needed).

### 2. Website UI Refinement

#### [MODIFY] [responsive_navbar.dart](file:///C:/Users/moham/StudioProjects/amr/lib/features/home/presentation/widgets/responsive_navbar.dart)
*   Remove the Notification Bell.
*   Remove the "Masari" link.
*   Focus on public links: Home, Courses, Teachers, About.

#### [MODIFY] [home_page.dart](file:///C:/Users/moham/StudioProjects/amr/lib/features/home/presentation/pages/home_page.dart)
*   Clean up the side drawer (remove notifications/dashboard links).
*   Ensure the landing page feels like a professional website (optimized spacing and headings).

### 3. "Website-First" Navigation
*   Ensure GoRouter uses clean URLs for web browser compatibility.
*   Optimize font sizes for desktop browsers.

## Verification Plan

### Manual Verification
1.  **Run the Site**: Verify it loads directly to Splash then Home.
2.  **Links**: Click through Home, Courses, Teachers, and About.
3.  **Booking**: Complete the Course Selection Wizard and verify it still leads to the professional WhatsApp message.
4.  **Login**: Verify Teachers can still log in to manage their profiles (optional, depending on cleanup depth).

### Code Quality
*   Run `flutter analyze` to ensure all dead code and unused imports are gone.
