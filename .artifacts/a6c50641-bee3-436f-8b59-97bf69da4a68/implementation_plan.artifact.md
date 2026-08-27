# Implementation Plan - Bedaya Online Teaching Platform

Create a modern, responsive online education website named "Bedaya" targeting the Arab world. The platform will support multiple instructors and a wide range of school courses.

## User Review Required

> [!IMPORTANT]
> **Arabic Support (RTL)**: Since the target audience is Arab countries, the entire UI will be designed with Right-to-Left (RTL) support as a primary requirement.
> **Backend Integration**: This plan focuses on the **Frontend (Flutter Web)**. We will use mock data initially. For a production-ready "advanced" site, we should discuss a backend (Firebase, Supabase, or custom API) later.
> **Advanced Competitive Features**: Based on market research (Noon Academy, Nafham, Edraak), we are adding social learning, gamification, and curriculum-specific filtering to make "Bedaya" stand out.

## Open Questions

> [!NOTE]
> Which Arab countries' curricula should we prioritize first? (e.g., Egypt, Saudi Arabia, UAE, etc.)
> Do you want to include a "Live Class" schedule UI from day one?

## Proposed Changes

### 1. Project Infrastructure & Dependencies
*   Add `flutter_localizations` for Arabic support.
*   Add `google_fonts` for professional Arabic typography (e.g., Cairo or Tajawal).
*   Add `riverpod` for scalable state management.
*   Add `go_router` for advanced web navigation and URL handling.
*   Add `flutter_svg` for crisp vector graphics.

### 2. Branding & Theming
*   **Colors**: Deep Blue & Emerald Green (Trust and Growth).
*   **Typography**: Clean, readable Arabic fonts.
*   **Logo**: Minimalist "Bedaya" (Beginning) branding.

### 3. Feature Set & UI Pages (Advanced Edition)
*   **Home Page**:
    *   **Responsive Navbar**: Login, Signup, and a "Country/Curriculum" selector.
    *   **Dynamic Hero**: Animated section welcoming students to "The Beginning of Excellence".
    *   **Live Now Widget**: Floating indicator showing if any of your friends are currently teaching live.
    *   **Trust Section**: Stats on students helped and courses covered.
*   **Smart Course Catalog**:
    *   **Curriculum Filter**: Filter by Country -> Grade -> Subject (Mathematics, Science, Arabic, etc.).
    *   **Micro-learning View**: Course structure broken down into short, digestible video segments.
*   **Instructor Profiles (The Team)**:
    *   Dedicated cards for you and your friends with bios, expertise, and "Request a Session" buttons.
### 6. Branding Integration (Logo & Exact Colors)
Incorporate the "Bidaya Academy" logo and refine the platform's color palette to match the branding.

#### [NEW] [assets/images/logo.png](file:///C:/Users/moham/StudioProjects/amr/assets/images/logo.png)
*   **Action Required**: User needs to save the provided logo image to this path.

#### [MODIFY] [app_theme.dart](file:///C:/Users/moham/StudioProjects/amr/lib/core/theme/app_theme.dart)
*   Update `primaryBlue` and `primaryGreen` to match the logo's specific shades.

#### [MODIFY] [responsive_navbar.dart](file:///C:/Users/moham/StudioProjects/amr/lib/features/home/presentation/widgets/responsive_navbar.dart)
*   Replace text-based "بداية" with the branding logo.

#### [MODIFY] [home_page.dart](file:///C:/Users/moham/StudioProjects/amr/lib/features/home/presentation/pages/home_page.dart)
*   Update the Mobile Drawer header and Hero section with logo integration.

#### [MODIFY] [login_page.dart](file:///C:/Users/moham/StudioProjects/amr/lib/features/auth/presentation/pages/login_page.dart)
*   Add the logo to the desktop welcome pane.

### 7. Splash / Loading Screen
Create a branded entry point for the app that handles initial setup.

#### [NEW] [loading_page.dart](file:///C:/Users/moham/StudioProjects/amr/lib/features/splash/presentation/pages/loading_page.dart)
*   Branded splash screen with the "Bidaya Academy" logo and a themed loading indicator.

#### [NEW] [init_provider.dart](file:///C:/Users/moham/StudioProjects/amr/lib/core/providers/init_provider.dart)
*   Manage the app's initialization state (Ready vs Loading).

#### [MODIFY] [main.dart](file:///C:/Users/moham/StudioProjects/amr/lib/main.dart)
*   Update `initialLocation` to `/splash`.
*   Add logic to redirect to `/` once the app is initialized.

### 8. Teachers Portfolio
A dedicated space to showcase the expertise of the "Bidaya Academy" teaching team.

#### [NEW] [instructor.dart](file:///C:/Users/moham/StudioProjects/amr/lib/features/teachers/domain/models/instructor.dart)
*   Model for instructors with `name`, `expertise`, `bio`, `rating`, and `experienceYears`.

#### [NEW] [teachers_repository.dart](file:///C:/Users/moham/StudioProjects/amr/lib/features/teachers/data/teachers_repository.dart)
*   Mock data for the initial teaching team.

#### [NEW] [teachers_portfolio_page.dart](file:///C:/Users/moham/StudioProjects/amr/lib/features/teachers/presentation/pages/teachers_portfolio_page.dart)
*   **Hero Header**: "Meet Our Excellence Team".
*   **Teacher Grid**: Responsive cards with high-quality photos.
*   **Filter Bar**: Filter by subject expertise.

#### [MODIFY] [main.dart](file:///C:/Users/moham/StudioProjects/amr/lib/main.dart)
*   Add `/teachers` route.

#### [MODIFY] [responsive_navbar.dart](file:///C:/Users/moham/StudioProjects/amr/lib/features/home/presentation/widgets/responsive_navbar.dart)
*   Add "Teachers" link to the navigation.

### 9. "About the Platform" & Free Session Booking
Create an informative and high-converting "About Us" page that highlights the platform's value and offers a free introductory session.

#### [NEW] [about_page.dart](file:///C:/Users/moham/StudioProjects/amr/lib/features/about/presentation/pages/about_page.dart)
*   **Vision Section**: Brief story of Bidaya Academy and its mission to empower Arab students.
*   **The "Bidaya Edge"**: 3-4 highlights (Elite Teachers, Modern Tools, Proven Results).
*   **Free Session Offer (CTA)**: A dedicated, visually striking section: *"Try before you join – Your first session is on us!"*
*   **Booking Form**: A low-friction contact form (Name, Subject, WhatsApp/Phone) specifically for the free session.

#### [MODIFY] [main.dart](file:///C:/Users/moham/StudioProjects/amr/lib/main.dart)
*   Add `/about` route.

#### [MODIFY] [responsive_navbar.dart](file:///C:/Users/moham/StudioProjects/amr/lib/features/home/presentation/widgets/responsive_navbar.dart)
*   Link "عن المنصة" to the new About page.

## Verification Plan

### Manual Verification
*   Test RTL layout consistency across all pages.
*   Verify responsiveness on Desktop, Tablet, and Mobile browser views.
*   Check font rendering for Arabic characters.

### Automated Tests
*   Widget tests for the navigation flow.
*   Unit tests for mock data providers.
